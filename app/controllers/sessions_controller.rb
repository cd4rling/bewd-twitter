class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:user][:username])
      if user&.authenticate(params[:user][:password])
        session = Session.create(user: user)
        cookies.permanent.signed[:twitter_session_token] = session.token
        render json: user, status: :created
      else
        render json: { error: "Invalid username or password" }, status: :unauthorized
      end
    end
  
    def authenticated
      session = Session.find_by(token: cookies.signed[:twitter_session_token])
      if session
        render json: session.user, status: :ok
      else
        render json: { error: "Not authenticated" }, status: :unauthorized
      end
    end
  
    def destroy
      session = Session.find_by(token: cookies.signed[:twitter_session_token])
      if session
        session.destroy
        cookies.delete(:twitter_session_token)
        render json: { message: "Logged out" }, status: :ok
      else
        render json: { error: "Not authenticated" }, status: :unauthorized
      end
    end
  end
  