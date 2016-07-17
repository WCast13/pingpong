class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
    Player.all
  end

  # GET /matches/new
  def new
    redirect_to login_path if session[:player_id].nil?
    @match = Match.new

  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)
    # p "*" * 50
    # p match_params
    # p "*" * 50
    @player_winner = Player.find_by(slack_name: match_params["winners_slack_name"])
    @player_loser = Player.find_by(slack_name: match_params["losers_slack_name"])

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
        @player_winner.wins += 1
        @player_winner.pf += @match.winners_score
        @player_winner.pa += @match.losers_score
        @player_loser.losses += 1
        @player_loser.pf += @match.losers_score
        @player_loser.pa += @match.winners_score
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
      params.require(:match).permit(:winners_slack_name, :losers_slack_name, :winners_score, :losers_score)
    end
end
