Rails.application.routes.draw do
  resources :projects, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    member do
      delete "delete_attachment/:attachment_id", to: "projects#delete_attachment", as: :delete_attachment
    end
  end
end