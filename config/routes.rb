Rails.application.routes.draw do
  get 'index/matches'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'matches', to: 'index#matches'
end
