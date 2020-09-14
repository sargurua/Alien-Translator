Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'translation#index'
  post '/translate', to: 'translation#create'
  post '/past_search', to: 'translation#past_search', :as => :past_search_path
end
