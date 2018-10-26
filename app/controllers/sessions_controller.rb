class SessionsController < ApplicationController
    #sign-in form
    def new
    end
    
    #submit form
    def create
        if params[:email].blank? || params[:password].blank?
            flash[:alert] = 'Email & Password Required!'
            render :new
            return
        end
        
        user = User.find_by email: params[:email]
        
        if user.present?
            
            if user.authenticate(params[:password])
                
                session[:current_user_id] = user.id
                redirect_to root_path, notice: " Welcome Back, #{user.first_name}!"
            else
                flash[:alert] = 'Email or Password Incorrect'
                render :new
                
            end
        else
            flash[:alert] = 'Email or Password Incorrect'
            render :new
        end
        
    end
    
    #logout
    def destroy
         session[:current_user_id] = nil
        redirect_to root_path, notice: "Goodbye for now!"
    end
    
end
