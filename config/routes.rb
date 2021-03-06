Rails.application.routes.draw do
  root 'top#index'

  resources :members
  resources :loan_items
  # resources :borrows,only:[:index,:edit,:update]
  resources :borrows, only:[:index,:edit,:update] do
    collection { get "search" }
  end
  resources :requests,only:[:index,:edit,:update]
  resources :account_activations, only: [:edit]
  resources :password_resets, only:[:new, :create, :edit, :update]
  resources :receive_requests, only:[:index,:show,:update]
  resources :borrow_items
  resources :borrow_replies, only: [:index,:edit,:update] do
    resources :borrow_reply_images,only: [:show,:destroy]
  end
  resources :tenders, only: [:index,:edit,:update] do
    collection { get "search" }
  end
  resources :receive_replies, only: [:index,:edit,:update]


  get    'signup'  => 'members#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'members' =>  'members#index'

  #modify for f5 reload error fix
  get 'borrows/:id' => 'borrows#edit'
  get 'requests/:id' => 'requests#edit'
  get 'password_resets' => 'password_resets#new'
  get 'password_resets/:id' => 'password_resets#edit'
  get 'borrow_replies/:id' => 'borrow_replies#edit'
  get 'tenders/:id' => 'tenders#edit'

  #resources :users
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
