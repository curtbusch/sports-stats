class TeamsController < ApplicationController
  def index
  end

  def show
    @Team = Team.find(params[:id])
  end
end
