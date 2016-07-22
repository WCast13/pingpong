class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # helper_method :current_player
  private
  def not_a_user
    return redirect_to '/players/new' if session[:player_user_name].nil?
  end
#assigns current league to the player
  def current_leauge
    if session[:player_user_name] != nil
    @current_leauge = @current_player.league
    end
  end
  # grabs current player by assinging session[:player_user_name]
  def current_player
    @current_player = Player.find_by(user_name: session[:player_user_name])
  end

end
