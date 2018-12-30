class GamesController < ApplicationController
  before_action :find_game!, only: [:show, :draw, :reset]

  def show
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to show_games_url(slug: @game.slug)
    end
  end

  def draw
    @game.draw
    render :show
  end

  def reset
    @game.reset
    render :show
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

  def find_game!
    @game = Game.friendly.find(params[:slug])
  end
end
