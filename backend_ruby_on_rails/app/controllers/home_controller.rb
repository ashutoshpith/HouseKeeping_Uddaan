class HomeController < ApplicationController
  def index
    @tasks = Task.all
    render json: @tasks
  end
end
