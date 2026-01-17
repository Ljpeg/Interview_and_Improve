Rails.application.routes.draw do
  devise_for :users
  root to: "applications#index"
end
