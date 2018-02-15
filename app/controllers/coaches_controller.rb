class CoachesController < ApplicationController
  def index
  end

  def show
    @coach = Coach.find(params[:id])
  end
end
