class GamesController < ApplicationController
  before_action :set_game!, only: [:show, :draw, :reset]
  before_action :find_game!, only: :update

  def show
  end

  def create
    @game = Game.find_or_initialize_by(game_params)
    if @game.save
      set_player!
      redirect_to_game
    end
  end

  def update
    set_player!
    redirect_to_game
  end

  def draw
    @game.draw
    redirect_to_game
  end

  def reset
    @game.reset
    redirect_to_game
  end

  private

  def set_player!
    @player = Player.find_or_create_by(name: player_params[:name], game: @game)
    @player.save
    cookies.permanent[:player] = @player.id
  end

  def redirect_to_game
    redirect_to show_games_url(slug: @game.slug)
  end

  def game_params
    params.require(:game).permit([:name, :slug])
  end

  def player_params
    params.require(:player).permit(:name)
  end

  def set_game!
    @game = Game.friendly.find(params[:slug])
    @player = Player.find(cookies[:player])
  end

  def find_game!
    @game = Game.friendly.find(game_params[:slug])
  end
end
