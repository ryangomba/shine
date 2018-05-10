ShineHeroku::Application.routes.draw do
  
  match "/admin" => "admin#index"
  
  resources :badges

end
