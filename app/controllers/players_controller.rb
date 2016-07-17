class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  #GET /login
  def login_page
  end
  #post /login
  def login
     @player = Player.find_by(user_name: params[:user_name])
      # If the player exists AND the password entered is correct.
      if @player && @player.authenticate(params[:password])
         session[:player_id] = @player.id
         @player.first_name
        redirect_to @player, alert: "Welcome, #{@player.first_name}"
        current_player
      else
          # If user's login doesn't work, send them back to the login form.
          # flash[:notice] =
      redirect_to login_path, alert: "unsucessful login"

      end
  end
  def logout
  session[:player_id] = nil
  redirect_to '/', alert: "You are now logged out"
end



  # GET /players
  # GET /players.json
  def standings
     redirect_to login_path if session[:player_id].nil?
     current_player
    Player.all.each do |player|
      if player.losses == 0 && player.wins == 0
        player.update(win_percentage: 0)
      elsif player.losses == 0
        player.update(win_percentage: 100)
      else
        player.update(win_percentage: (player.wins/(player.wins + player.losses)) * 100)
      end

    end


    @players = Player.all.sort { |a,b|
      a.win_percentage == b.win_percentage ? b.pf <=> a.pf : b.win_percentage <=> a.win_percentage
    }
    end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    @player.wins = 0
    @player.losses = 0
    @player.pf = 0
    @player.pa = 0
    @player.win_percentage = 0
    current_player
    respond_to do |format|
      if @player.save
        session[:player_id] = @player.id

        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:first_name, :last_name, :user_name, :password, :password_confirmation)
    end
end
