class GamesController < ApplicationController
  before_action :set_game!, only: [:show, :draw, :reset, :select_number]
  before_action :find_game!, only: :update

  def show
  end

  def create
    @game = Game.find_or_initialize_by(game_params.except(:slug))
    if @game.save
      set_player!(master: true)
      redirect_to_game
    end
  end

  def update
    set_player!(master: false)
    redirect_to_game
  end

  def draw
    @game.draw
    ActionCable.server.broadcast 'last_number',
        last_number: @game.last_number
    redirect_to_game
  end

  def reset
    @game.reset
    ActionCable.server.broadcast 'reset', {}
    redirect_to_game
  end

  def select_number
    @player.select_number(params[:number])
    redirect_to_game
  end

  private

  def set_player!(master:)
    @player = Player.find_or_create_by(name: player_params[:name], game: @game)
    @player.master = master
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
