class HomeController < ApplicationController
  def index
    @actors = Actor.all
  end
end
