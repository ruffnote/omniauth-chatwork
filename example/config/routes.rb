Rails.application.routes.draw do
  get '/auth/chatwork/callback', to: 'welcome#callback'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
