class GamesController < ApplicationController
  def show
    @game = Game.friendly.find(params[:slug])
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to show_games_url(slug: @game.slug)
    end
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
