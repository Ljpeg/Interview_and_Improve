Rails.application.routes.draw do
  # Routes for the Interview resource:

  # CREATE
  post("/insert_interview", { :controller => "interviews", :action => "create" })

  # READ
  get("/interviews", { :controller => "interviews", :action => "index" })

  get("/interviews/:path_id", { :controller => "interviews", :action => "show" })

  # UPDATE

  post("/modify_interview/:path_id", { :controller => "interviews", :action => "update" })

  # DELETE
  get("/delete_interview/:path_id", { :controller => "interviews", :action => "destroy" })

  #------------------------------

  # Routes for the Job application resource:
  resources :job_applications
  #------------------------------
  devise_for :users
  root to: "job_applications#index"
end
