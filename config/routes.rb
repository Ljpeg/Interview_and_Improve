Rails.application.routes.draw do
  # Routes for the Reflection resource:

  # CREATE
  post("/insert_reflection", { :controller => "reflections", :action => "create" })

  # READ
  get("/reflections", { :controller => "reflections", :action => "index" })

  get("/reflections/:path_id", { :controller => "reflections", :action => "show" })

  # UPDATE

  post("/modify_reflection/:path_id", { :controller => "reflections", :action => "update" })

  # DELETE
  get("/delete_reflection/:path_id", { :controller => "reflections", :action => "destroy" })

  #------------------------------

  resources :job_applications do
    resources :interviews
  end 
  #------------------------------
  devise_for :users
  root to: "job_applications#index"
end
