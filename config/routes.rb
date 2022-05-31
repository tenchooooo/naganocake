Rails.application.routes.draw do
  root to: "public/homes#top"
  get '/about' => 'public/homes#about'
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  resources :customers, only: [:show, :edit, :update,], controllers: {
    customers: "public/customers"
  }
  get '/customers' => 'public/customers#confirm'
  patch '/customers/withdraw' => 'public/customers#withdraw'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

end
