class HomepageController < ApplicationController
  def home
    current_player
    if @current_player.nil?
      redirect_to '/'
    end
  end
end
