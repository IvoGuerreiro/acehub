class IndexController < ApplicationController
  def matches

    @matches = Match.where(kickoff: (Time.now - 3.hours)..(Time.now + 9.hours)).order(:kickoff)

    render json: @matches
  end
end
