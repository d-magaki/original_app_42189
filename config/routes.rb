Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update, :destroy]

  resources :tasks, only: [:index, :show, :edit, :update, :destroy]
  
  resources :projects, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    member do
      delete "delete_attachment/:attachment_id", to: "projects#delete_attachment", as: :delete_attachment
    end
  end

  root to: "projects#index"
end