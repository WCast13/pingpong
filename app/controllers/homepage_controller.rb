class HomepageController < ApplicationController
  def home
    current_player
      not_a_user
      if @current_player && @current_player.user_name != "admin"
      @player_ladder = @current_player.standings_position
      if @current_player.standings_position != 1
      @one_up_ladder = Player.find_by(standings_position: @current_player.standings_position - 1).user_name
      if @current_player.standings_position >= 2
      @two_up_ladder = Player.find_by(standings_position: @current_player.standings_position - 2).user_name
      end
    end
    end
# dfasfsfsafs
    end
end
