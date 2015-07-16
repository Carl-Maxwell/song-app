class SessionsController < ApplicationController
  before_action :require_guest, only: [:new, :create]
  before_action :require_user, only: [:destroy]

  def new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user
      login(user)

      redirect_to user_url(user)
    else
      redirect_to new_session_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    render text: "You have been logged out"
  end
end
