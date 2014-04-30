VacationTool::Application.routes.draw do
 
  root "vacations#home"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  #get "vacations/home"
  get "static_pages/home"
  get "users/users_sign_in"
  
  get 'leaves/:id/approve_leave' => 'leaves#approve_leave' , :as => 'approve_leave'
  get 'leaves/:id/unapprove_leave' => 'leaves#unapprove_leave' , :as => 'unapprove_leave'
  match 'leaves/requests', to: 'leaves#requests', via: 'get'
  match 'leaves/requests/new', to: 'leaves#new' , via: 'get'
  # match '/employees_requests', to: 'vacations#leave_request', via: 'get'
  match '/employees_list', to: 'vacations#show_all_emp', via: 'get'

  resources :vacations
  resources :users
  resources :leaves
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
