class IndexController < ApplicationController
  def matches
    now = DateTime.now.utc

    @matches = Match.where(kickoff: (Time.now - 3.hours)..(Time.now + 9.hours)).order(:kickoff)

    render json: @matches
  end
end
