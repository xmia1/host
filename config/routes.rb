Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :blogs, only: [:update]

  get 'update_blog', to: 'blogs#edit', as: :update_blog

  # , :shallow => true do
  resources :posts
  devise_for :users
  root to: "home#index"
  get "/pages/:page" => "pages#show"
  get "/blogs/publish" => "blogs#publish_blog"
  # get '/users/password/new', to: redirect('/pages/forgot_password')
  get '*path' => redirect('/')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
