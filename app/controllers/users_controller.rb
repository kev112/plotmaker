class UsersController < ApplicationController
    get '/signup' do 
        if logged_in?
            redirect '/plots'
        else
            erb :'users/signup'
        end
    end

    post '/signup' do 
        @user = User.new(params)

        if @user.save
            session[:user_id] = @user.id
            flash[:message] = "Signup successful."
            redirect "/plots"
        else
            flash[:message] = "Please try again. #{@user.errors.full_messages.to_sentence}"
            redirect "/signup"
        end
    end

    get '/login' do 
        if logged_in?
            redirect '/plots'
        else
            erb :'users/login'
        end
        
    end

    post '/login' do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/plots'
        else
            flash[:message] = "Error. Please try logging in again, or sign up for a new account."
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end

