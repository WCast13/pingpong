class HomepageController < ApplicationController
  def home
    current_player
      not_a_user
      # Player.find(2).update(standings_position: 1)
      # Player.find(1).update(standings_position: 2)
      if @current_player
      @player_ladder = @current_player.standings_position
      if @current_player.standings_position != 1
      @one_up_ladder = Player.find_by(standings_position: @current_player.standings_position - 1).user_name
    elsif @current_player.standings_position >= 2
      @two_up_ladder = Player.find_by(standings_position: @current_player.standings_position - 2).user_name
      end
    end
    end
end
