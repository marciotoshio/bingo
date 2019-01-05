class GamesController < ApplicationController
  before_action :set_game!, only: [:show, :draw, :reset, :select_number]

  def create
    @game = Game.find_or_initialize_by(name: game_params[:name])
    if @game.save
      set_player!
      redirect_to_game
    end
  end

  def update
    @game = find_game(game_params[:slug])
    set_player!
    redirect_to_game
  end

  def show
  end

  def draw
    @game.draw
    ActionCable.server.broadcast("game_#{@game.id}",
      action: 'set_last_number',
      last_number: @game.last_number_with_column
    )
  end

  def reset
    @game.reset
    ActionCable.server.broadcast("game_#{@game.id}",
      action: 'reset'
    )
    redirect_to_game
  end

  def select_number
    @player.select_number(params[:number])
    redirect_to_game
  end

  private

  def set_player!
    @player = Player.find_or_create_by(name: player_params[:name], game: @game)
    @player.master = @game.needs_master?
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
end
