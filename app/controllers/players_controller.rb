class PlayersController < ApplicationController
  def show
    game = find_game(params[:slug])
    player = find_player(game, params[:id])
    @no_link = true
    render partial: 'show', locals: { player: player }
  end
end
