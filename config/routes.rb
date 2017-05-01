Rails.application.routes.draw do
  get 'pages/welcome'

  get 'pages/contact'



  resources :histories do
    collection do
      post :add_rep
    end
  end
  devise_for :users
  resources :cards do
    
    collection do
      # post :next_card
      # post :previous_card
      post :choiceA_selected
      post :choiceB_selected
      post :choiceC_selected
      post :choiceD_selected
      post :change_level_to_easy
      post :change_level_to_medium
      post :change_level_to_hard
      
      post:reset_rep
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# root to: 'cards#index'
 root to: 'pages#welcome'
 post 'cards/choiceA/:level' => 'cards#choiceA'
end
