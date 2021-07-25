# frozen_string_literal: true

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

  def broadcast_last_number
    message = { action: 'set_last_number', last_number: @game.last_number_with_column }
    ActionCable.server.broadcast("game_#{@game.id}", message)
  end

  def broadcast_reset
    ActionCable.server.broadcast("game_#{@game.id}", { action: 'reset' })
  end

  def broadcast_new_player
    message = {
      action: 'new_player',
      player: {
        name: @player.name,
        url: player_games_path(slug: @game.slug, id: @player.id)
      }
    }
    ActionCable.server.broadcast("game_#{@game.id}", message)
  end
end
