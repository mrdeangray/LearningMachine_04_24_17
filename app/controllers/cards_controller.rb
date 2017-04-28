class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]


def choiceA
  card = Card.find(session[:current_id] )
  # card.level = params[:level]
  card.save
  redirect_to cards_path
    
end

def change_level_to_easy
  card = Card.find(session[:current_id] )
  card.level = "Easy"
  card.save
  redirect_to cards_path
end

def change_level_to_medium
  card = Card.find(session[:current_id] )
  card.level = "Medium"
  card.save
  redirect_to cards_path
end

def change_level_to_hard
  card = Card.find(session[:current_id] )
  card.level = "Hard"
  card.save
  redirect_to cards_path
end


def choiceA_selected
  if session[:current_id] == session[:choiceA_id]
  # flash[:success] = "Correct!"
    next_card()
  else
    flash[:danger] = "Inorrect!"
   redirect_to cards_path
  end
end

def choiceB_selected
  if session[:current_id] == session[:choiceB_id]
  # flash[:success] = "Correct!"
    next_card()
  else
    flash[:danger] = "Inorrect!"
    redirect_to cards_path
  end
end

def choiceC_selected
  if session[:current_id] == session[:choiceC_id]
  # flash[:success] = "Correct!"
    next_card()
  else
    flash[:danger] = "Inorrect!"
    redirect_to cards_path
  end
end

def choiceD_selected
  if session[:current_id] == session[:choiceD_id]
  # flash[:success] = "Correct!"
    next_card()
  else
    flash[:danger] = "Inorrect!"
    redirect_to cards_path
  end
end

def reset_rep
  Card.all.each do |card|
    card.rep = 0
    card.save
  end
  session[:todays_rep_count] = 0
  redirect_to cards_path
end

# def next_card
#   card = Card.find(session[:current_id] )
#   card.rep +=1
#   # session[:card_level] = params[:level]
#   # card.level = session[:card_level]
#   card.save
  
#     if session[:current_id] < 5
#         session[:current_id] +=1
#     else
#         session[:current_id] =1
#     end
#     session[:todays_rep_count] +=1
    
#     redirect_to cards_path
# end
def next_card
  card = Card.find(session[:current_id] )
  card.rep +=1
  # session[:card_level] = params[:level]
  # card.level = session[:card_level]
  card.save
    if session[:todays_rep_count] % 5 ==0 #5, 10,9 12 15
        @card = Card.all.where(:level => 'Medium').order(:updated_at).first
    elsif session[:todays_rep_count] %2 == 0 #0,2,4
       @card = Card.all.where(:level => 'Hard').order(:updated_at).first
    else                                     #5 7 11 13 17
        @card = Card.all.where(:level => 'Easy').order(:updated_at).first
    end
    session[:current_id] = @card.id
    session[:todays_rep_count] +=1
 
    redirect_to cards_path
end



  # GET /cards
  # GET /cards.json
  def index
    session[:current_id] ||= 1
    session[:choiceA_id] ||= 1
    session[:choiceB_id] ||= 1
    session[:choiceC_id] ||= 1
    session[:choiceD_id] ||= 1
    session[:todays_rep_count] ||=0
    gen_rand_ids()
 # generate 4 unique random numbers between 1 and 5 in an array
       @my_array=(1..5).to_a.sample(4)
       if !@my_array.include? session[:current_id].to_i
         rand_index = 0 + rand(4) 
          @my_array[rand_index ] = session[:current_id].to_i
       end
    session[:choiceA_id] = @my_array[0]
    session[:choiceB_id] = @my_array[1]
    session[:choiceC_id] = @my_array[2]
    session[:choiceD_id] = @my_array[3]  
    
     @card = Card.find(session[:current_id] )
    # @card.level = session[:card_level]
    # @card.save
    @cards = Card.all
  end
  
  def gen_rand_ids
   
    # my_array = Array.new(4) { rand(1...9) }
    #if array contains current_id, do nothing
    #else n=random number between 1 and 3
    #replace the n element with current_id
    #iterate through the array and assign each element to choiceA_id...
    Array.new(4)
    #generate 4 random numbers that rep where the answer will be placed

    
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:question, :answer, :media, :comment, :rep, :level, :category, :user_id)
    end
end
