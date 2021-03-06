Rails.application.routes.draw do
  get '/dives' => 'dives#index'
  post '/dives' => 'dives#create'
  get '/dives/new' => 'dives#new', as: 'new_dive'
  get '/dives/:id/edit' => 'dives#edit', as: 'edit_dive'
  get '/dives/:id' => 'dives#show', as: 'dive'
  put '/dives/:id' => 'dives#update'
  patch '/dives/:id' => 'dives#update'
  delete '/dives/:id' => 'dives#destroy'
  delete '/dives/:id/fish/:fish_id' => 'dives#removefish'
  post '/dives/:id/fish' => 'dives#addfish'

  post '/dives/:id/divers' => 'dives#adddiver'
  delete '/dives/:id/divers/:diver_id' => 'dives#removediver'

  get '/divers' => 'divers#index'
  get '/divers/:id' => 'divers#show', as: 'diver'

  post '/photos' => 'photos#create'
  delete '/photos/:id' => 'photos#destroy'

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  root 'root#index'

# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

# You can have the root of your site routed with "root"
# root 'welcome#index'

# Example of regular route:
#   get 'products/:id' => 'catalog#view'

# Example of named route that can be invoked with purchase_url(id: product.id)
#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

# Example resource route (maps HTTP verbs to controller actions automatically):
#   resources :products

# Example resource route with options:
#   resources :products do
#     member do
#       get 'short'
#       post 'toggle'
#     end
#
#     collection do
#       get 'sold'
#     end
#   end

# Example resource route with sub-resources:
#   resources :products do
#     resources :comments, :sales
#     resource :seller
#   end

# Example resource route with more complex sub-resources:
#   resources :products do
#     resources :comments
#     resources :sales do
#       get 'recent', on: :collection
#     end
#   end

# Example resource route with concerns:
#   concern :toggleable do
#     post 'toggle'
#   end
#   resources :posts, concerns: :toggleable
#   resources :photos, concerns: :toggleable

# Example resource route within a namespace:
#   namespace :admin do
#     # Directs /admin/products/* to Admin::ProductsController
#     # (app/controllers/admin/products_controller.rb)
#     resources :products
#   end
end
