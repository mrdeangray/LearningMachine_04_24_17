Rails.application.routes.draw do
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
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 root to: 'cards#index'
 post 'cards/choiceA/:level' => 'cards#choiceA'
end
