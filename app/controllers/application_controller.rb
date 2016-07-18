class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  private
  def current_player
    if session[:player_id]
    @current_player = Player.find(session[:player_id])
  else
    @current_player = nil
  end
end
  helper_method :current_player
end
