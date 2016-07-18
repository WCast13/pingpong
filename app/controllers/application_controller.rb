class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  private
  def admin_access
    redirect_to '/' if @current_player.user_name != "admin"
  end
  def current_player
    if session[:player_id] != nil
    @current_player = Player.find(session[:player_id])
    end
  end
  helper_method :current_player

end
