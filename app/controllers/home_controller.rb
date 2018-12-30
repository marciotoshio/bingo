class HomeController < ApplicationController
  def index
    @game = Game.find_or_initialize_by(slug: params[:game])
  end
end
