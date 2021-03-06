WeddingRsvp::Application.routes.draw do
  resources :rsvps do
    get 'export', on: :collection
  end

  resources :blogs , except: [ :show, :update, :new ] do
    get 'manage', on: :collection
  end

  resources :guestbooks, except: [ :show, :update, :edit, :new ] do
    get 'manage', on: :collection 
    get 'flag', on: :member
    get 'approve', on: :member
    get 'export', on: :collection
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#index'

  get 'contact' => 'static_pages#contact'

  post 'send_mail' => 'static_pages#send_mail' 

  get 'registry' => 'static_pages#registry'

  get 'hotels' => 'static_pages#hotels'

  post 'rsvps/create' => 'rsvps#create'

  # get 'tehachapi' => 'static_pages#tehachapi'
  # get 'hotels' => 'static_pages#hotels'
  # get 'restaurants' => 'static_pages#restaurants'
  # get 'registry' => 'static_pages#registry'

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
