DemoBlog::Application.routes.draw do |map|
  
  root :to => "welcome#index"
  
  match "archives" => "welcome#archives", :as => "archives"
  match "about" => "welcome#about", :as => "about"  
  match "contact" => "welcome#contact", :as => "contact"  

  devise_for :users, :path_names => { :sign_in => 'login', :sign_up => 'register', :sign_out => 'logout' } #Has To Be Before Users Resource Below
  
  resources :users
  resources :posts
  resources :comments
  resources :category
  
end
