Rails.application.routes.draw do
  resources :job_applications do
    resources :interviews
  end 
  #------------------------------
  devise_for :users
  root to: "job_applications#index"
end
