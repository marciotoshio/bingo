class ApplicationController < ActionController::Base
  def set_game!
    @game = find_game(params[:slug])
    @player = find_player(@game, cookies[:player])
  end

  def find_game(slug)
    Game.friendly.find(slug)
  end

  def find_player(game, id)
    game.players.find(id)
  end
end
