class PlayersController < ApplicationController
  def show
    game = find_game(params[:slug])
    player = find_player(game, params[:id])
    render partial: 'show', locals: { player: player }
  end
end
