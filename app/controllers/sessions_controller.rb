class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(params[:email], params[:password])

    if user
      user.reset_session_token!
      session[:session_token] = user.session_token
    else
      redirect new_session_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    render text: "You have been logged out"
  end
end
