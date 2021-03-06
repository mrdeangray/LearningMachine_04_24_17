class HistoriesController < ApplicationController
  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  
  before_action :require_same_user, only: [:edit, :delete]



def add_rep
  # @h=History.create(date: Date.yesterday, reps: 10)
  # @h = History.all.where(:date => Date.today).first
  @h = History.all.where(:date => Time.zone.now.to_date).first
  if !@h.nil?
    @h.repCount +=1
    @h.save
  else
    @h=History.create(date: Time.zone.now.to_date, repCount: 1) #instead of Date.today
  end
  # @h = History.find(1)
  # @h.date = 
  # @h.rep +=1
  # @h.save
  redirect_to histories_path
end

  # GET /histories
  # GET /histories.json
  def index
    # @histories = History.all
    # @histories = History.all.where(:date => Date.today, :user_id => current_user.id.to_i).first
    @histories = History.all.where(:user_id => current_user.id.to_i)
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # GET /histories/new
  def new
    @history = History.new
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    @history = History.new(history_params)

    respond_to do |format|
      if @history.save
        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.json { render :show, status: :created, location: @history }
      else
        format.html { render :new }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    respond_to do |format|
      if @history.update(history_params)
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render :show, status: :ok, location: @history }
      else
        format.html { render :edit }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url, notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
      session[:repCount] ||=@history.repCount
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:date, :repCount, :user_id)
    end
    
    
    def require_user
        if !user_signed_in?
            flash[:danger]='you need to log in first'
            redirect_to pages_welcome_path
        end
    end
    
    def require_same_user
        if user_signed_in? and @card.user_id != current_user.id
            flash[:danger]='you are not the same user'
            redirect_to login_path
        end
    end
    
    
end
