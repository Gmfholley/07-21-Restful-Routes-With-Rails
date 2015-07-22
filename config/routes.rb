Rails.application.routes.draw do
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
  
  
  # Routes for Users
  get "/" => 'users#login' 
  get "/users" => 'users#index'
  get "/new_user" => 'users#create_form'
  post "/new_user" => 'users#create_user'
  post "/users/login" => 'users#login_user'
  get "/delete_profile" => 'users#delete_profile_form'
  delete "/delete_profile" => 'users#delete_profile'
  get "/edit_profile" => 'users#edit_profile_form'
  put "/edit_profile" => 'users#edit_profile' 
  get "/users/:id" => 'users#profile'
  get "/profile" => 'users#my_profile' 
  
  # Routes for posts
  get "/users/:id/posts" => 'posts#index'
  get "/new_post" => 'posts#new_post_form'
  post "/new_post" => 'posts#new_post'
  get "/delete_post/:id" => 'posts#delete_post_form'
  delete "/delete_post/:id" => 'posts#delete_post'
  get "/edit_post/:id" => 'posts#edit_post_form'
  put "/edit_post/:id" => 'posts#edit_post'
  get "/posts/:id" => 'posts#post'
  
  
  # Routes for votes
  get "/posts/:id/vote" => 'posts#vote'
  get "/posts/:id/unvote" => 'posts#unvote'
end
