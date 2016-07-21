class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  before_action :current_player
  before_action :admin_access, only: [:index, :show, :edit, :update, :destroy]
  before_action :not_a_user
  # before_action :admin, only: [:show, :edit, :update, :destroy]
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
    redirect_to '/', alert: "Please log-in, or create a new player in order to submtit a score" if session[:player_id].nil?
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
    @current_player.update(standings_position: 1)
    @current_player.update(wins: 0)
      @current_player.update(losses: 0)
    opponent = Player.find_by(user_name: @match.opponent_username)
    sp = opponent.standings_position
#This is to get rid of names that are not in our database
      if Player.all.map(&:user_name).exclude?(@match.opponent_username)
        return redirect_to '/matches/new', alert: 'Your opponent was not found, please try again.'
        #This is if the scores are equal
      elsif @match.your_score == @match.opponent_score
        return redirect_to '/matches/new', alert: "There's no ties in ping pong, like there is no ties in life"
        #This is if the current user tries to play himself
      elsif @match.opponent_username == @current_player.user_name
        return redirect_to '/matches/new', alert: "You can't play yourself in pingpong unless your Forest Gump"
        #This is if the current user, but what if the opponent is the one with 0 wins/losses...fml
      # elsif @current_player.wins == 0 && @current_player.losses == 0 || (opponent.wins == 0 && opponent.losses == 0)
      #   return render_page
        #Last thing I need to do!!!!!!!!!!is...fix the positions when a player first enters the league
      elsif !@current_player.standings_position.between?(sp - 2, sp + 2)
        return redirect_to '/matches/new', alert: "Opponent has to be within 2 ladder positions of you"
      end
    render_page
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


    def determine_score(match)
      opponent = Player.find_by(user_name: match_params["opponent_username"])
        #current player won :)
      if match.your_score > match.opponent_score
         @player_winner = @current_player
         @player_loser = opponent
         @player_winner.pf += match.your_score
         @player_loser.pf += match.opponent_score
         @player_winner.pa += match.opponent_score
         @player_loser.pa += match.your_score
          if @current_player.standings_position > opponent.standings_position
            change_ladder_positions
          end

         #Your opponent won the match
      else
         @player_winner = opponent
         @player_loser = @current_player
         @player_winner.pf += @match.opponent_score
         @player_loser.pf += @match.your_score
         @player_winner.pa += @match.opponent_score
         @player_loser.pa += @match.your_score
          # if opponent.standings_position > @current_player.standings_position
          if @current_player.standings_position < opponent.standings_position
            change_ladder_positions
          end

        end
         @player_winner.wins += 1
         @player_loser.losses += 1
         #You win, and #

         @player_winner.save
         @player_loser.save


    end

    # def create_playermatch
    #   PlayerMatch.create(player_id: @current_player.id, match_id: @match.id)
    #   PlayerMatch.create(player_id: Player.find_by(user_name: match_params["opponent_username"]).id, match_id: @match.id)
    # end


    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:opponent_username, :opponent_score, :your_score)
    end
    def admin_access
      return redirect_to '/' if @current_player.nil? || @current_player.user_name != "admin"
    end
    def change_ladder_positions

      opponent = Player.find_by(user_name: match_params["opponent_username"])
      #current player is 1, opponent 2
      if @current_player.standings_position + 1 == opponent.standings_position
        @current_player.update(standings_position: opponent.standings_position)
        opponent.update(standings_position: @current_player.standings_position - 1)
        #current player 1, opponnet 3
      elsif  @current_player.standings_position + 2 == opponent.standings_position#opponent 2/3, current 1
        @current_player.update(standings_position: opponent.standings_position)
        opponent.update(standings_position: @current_player.standings_position - 2)
        #current player 2, opponent 1
      elsif opponent.standings_position + 1 == @current_player.standings_position
        @current_player.update(standings_position: opponent.standings_position)
        opponent.update(standings_position: @current_player.standings_position + 1)
        #current player 3, opponent 1
      elsif opponent.standings_position + 2 == @current_player.standings_position
        @current_player.update(standings_position: opponent.standings_position)
        opponent.update(standings_position: @current_player.standings_position + 2)

      end
    end
    def render_page
      respond_to do |format|
        if @match.save
          # create_playermatch
          determine_score(@match)
        # p   @current_player.save
        # p   Player.find_by(user_name: match_params["opponent_username"]).save

          format.html { redirect_to '/standings', notice: 'Match was successfully created.' }
          format.json { render :show, status: :created, location: '/standings' }
          #You won the match
        else
          format.html { render :new }
          format.json { render json: @match.errors, status: :unprocessable_entity }
        end
      end
    end
  end
