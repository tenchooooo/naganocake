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
  scope module: :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'complete'
      end
    end

    resources :addresses, only: [:index, :edit, :create, :update, :destroy] do
    end

    get '/customers/my_page' => 'customers#show'
    get '/customers/my_page/edit' => 'customers#edit'
    patch '/customers/my_page' =>'customers#update'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw'

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    root to: "homes#top"
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
  end

end
