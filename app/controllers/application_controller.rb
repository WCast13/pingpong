class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  private
  def current_leauge
    if session[:player_id] != nil
    @current_leauge = @current_player.league
  end
  end
  def current_player
    if session[:player_id] != nil
    @current_player = Player.find(session[:player_id])
    end
  end
  helper_method :current_player

end
