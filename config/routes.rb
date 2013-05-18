Cinimaker::Application.routes.draw do

  devise_for :users, :controllers => { :sessions => :sessions, :registrations => "registrations" } do 
    match 'user/profile', :to => 'registrations#edit'
  end

  root :to => 'homes#cinimaker_home'
  
  namespace :user do
    resources :followings do
      member do
        get :unfollow_user
        get :unfollow_cini
      end
    end  
    resources :cinis do
      member do
        get :follow_cini
        get :unfollow_cini
        get :change_cini_status
      end
      resources :needs
      resources :roles do
        collection do
          get :set_admin
        end
        member do
          get :invite
          post :accept_role_request
          post :un_assign_role
        end
      end
      resources :galleries, :controller => "cinis_galleries" do
        resources :images , :controller => "cinis_images"
      end
      resources :videos, :controller => "cinis_videos"
    end  
    resources :connections do
      member do
        get :add_connection
        delete :brack_connection
      end
    end
    resources :profile
    resources :credits
    resources :account do 
      collection do
        post :change_to_creative
      end
    end
    resources :reels
    resources :comments
    resources :galleries do
      resources :images do
        collection do
          post 'create_image_comment'
        end
          member do
            get :delete_image_comment
          end
      end
    end
  end
  
  resources :homes do
    collection do
      get 'more_feeds'
      get 'more_needs'
    end
  end
  
  scope "/user" do
    scope "/inbox" do
      resources :messages      
      resources :connections 
      resources :roles, :controller => "roles_requests" do 
        member do 
          get :update_status
        end 
      end
      resources :notifications
      match '/needs', :to => "inbox_needs#index"
    end
  end

  match 'user/inbox' => redirect("/user/inbox/messages")
  match 'user/privacy', :to => 'users#privacy'
  match '/users/update_privacy' => "users#update_privacy"

  resources :users do
    post :update_status
    resources :cinis, :controller => "user_public_cinis", :only => [:index, :show], :as => "public_cinis"
    resources :galleries, :controller => "user_public_galleries", :only => [:index, :show], :as => "public_galleries"
    resources :reels, :controller => "user_public_reels", :only => [:index, :show], :as => "public_reels" do
      collection do
        post 'create_reel_comment'
      end
    end  
    resources :credits, :controller => "user_public_credits", :only => [:index, :show], :as => "public_credits"
    resources :updates, :controller => "user_public_updates", :only => [:index, :show], :as => "public_updates"
  end

  resources :cinis do
    member do
      get :cini_follow_on_public
      get :cini_unfollow_on_public
    end  
    collection do
      get 'more_feeds'
      get 'more_needs'
    end
    resources :galleries, :controller => "cini_public_galleries", :only => [:index, :show], :as => "cini_public_galleries"
    resources :videos, :controller => "cini_public_videos", :only => [:index, :show], :as => "cini_public_videos" do
      collection do
        post :create_reel_comment
      end
    end
    resources :crew, :controller => "cini_public_roles", :only => [:index, :show], :as => "cini_public_roles" do
      member do
        post :role_request
      end
    end
    resources :updates, :controller => "cini_public_updates", :only => [:index, :show], :as => "cini_public_updates"
    resources :needs, :controller => "cini_public_needs", :only => [:index, :show], :as => "cini_public_needs"
  end

  match '/cinimakers' => "users#cinimakers"
  match '/cinis' => "users#cinis"

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

end
