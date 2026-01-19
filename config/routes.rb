Rails.application.routes.draw do

  #------------------------------
  resources :job_applications do
    resources :interviews, shallow: true do
      resources :reflections do
        resources :learning_items, shallow: true
      end
    end
  end
  #------------------------------
  devise_for :users
  root to: "job_applications#index"
end
