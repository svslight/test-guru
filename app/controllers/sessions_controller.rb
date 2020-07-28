class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      # redirect_to tests_path
      redirect_to cookies[:path]
    else
      flash[:alert] = 'Введен некорректный электронный адрес или пароль'
      # render :new
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
