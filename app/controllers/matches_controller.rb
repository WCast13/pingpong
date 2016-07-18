class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  before_action :current_player
  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
     #admin
    Player.all
  end

  # GET /matches/new
  def new
    @match = Match.new

  end


  # GET /matches/1/edit
  def edit
    # redirect_to '/' if session[:player_id]
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)
    player_name_array = []
    Player.all.each do |player|
      player_name_array << player.user_name
    end
      if player_name_array.exclude?(@match.opponent_username)
        return redirect_to '/matches/new', alert: 'Your opponent was not found, please try again.'
      end

    respond_to do |format|
      if @match.save
        format.html { redirect_to '/standings', notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: '/standings' }
        #You won the match
              if @match.your_score > @match.opponent_score
            @player_winner = @current_player
            @player_loser = Player.find_by(user_name: match_params["opponent_username"])
            @player_winner.pf += @match.your_score
            @player_loser.pf += @match.opponent_score
            @player_winner.pa += @match.opponent_score
            @player_loser.pa += @match.your_score
            #Your opponent won the match
            else
            @player_winner = Player.find_by(user_name: match_params["opponent_username"])
            @player_loser = @current_player
            @player_winner.pf += @match.opponent_score
            @player_loser.pf += @match.your_score
            @player_winner.pa += @match.opponent_score
            @player_loser.pa += @match.your_score
            end
        @player_winner.wins += 1
        @player_loser.losses += 1

        @player_winner.save
        @player_loser.save
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:opponent_username, :opponent_score, :your_score)
    end
  end
