# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_game!, only: %i[show draw reset select_number]

  def create
    @game = Game.find_or_initialize_by(name: game_params[:name])
    return unless @game.save

    set_player!
    redirect_to_game
  end

  def update
    @game = find_game(game_params[:slug])
    set_player!
    broadcast_new_player
    redirect_to_game
  end

  def show; end

  def big
    @game = find_game(params[:slug])
  end

  def show_qr_code
    @game = find_game(params[:slug])
    broadcast_show_qr_code
  end

  def draw
    @game.draw
    broadcast_last_number
    head :ok
  end

  def reset
    @game.reset
    broadcast_reset
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
    params.require(:game).permit(%i[name slug])
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
