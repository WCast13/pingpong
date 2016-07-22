class HomepageController < ApplicationController
  #GET '/home'
  def home
    #assigns @current_player based on who is logged in
    current_player
    #redicts to create player/login if new user
      not_a_user
      #sets up who are the people that current user can play against
      if @current_player && @current_player.user_name != "admin"
      @player_ladder = @current_player.standings_position
      if @current_player.standings_position != 1
      @one_up_ladder = Player.find_by(standings_position: @current_player.standings_position - 1)
      if @current_player.standings_position >= 2
      @two_up_ladder = Player.find_by(standings_position: @current_player.standings_position - 2)
      end
    end
    end
    end
    #GET '/rules'
    def rules
    end
end
