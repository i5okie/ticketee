Rails.application.routes.draw do
  namespace :admin do
    root 'base#index'

    resources :projects, only: [:new, :create, :destroy]
    resources :users
    resources :states, only: [:index, :new, :create] do
      member do
        get :make_default
      end
    end
  end

  namespace :api do
    scope path: "/projects/:project_id", as: "project" do
      resources :tickets
    end
  end

  devise_for :users

  root "projects#index"
  
  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      collection do
        get :search
      end

      member do
        post :watch
      end
    end
  end

  resources :tickets, only: [] do
    resources :comments, only: [:create]
    resources :tags, only: [] do
      member do
        delete :remove
      end
    end
  end

  resources :assets, only: [:show, :new], path: :files
end
