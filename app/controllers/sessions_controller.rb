class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user) if user_signed_in?
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      redirect_to user_path(user)
    else
      if user
        flash.now[:alert] = 'senha inválida'
      else
        flash.now[:alert] = "Email: #{params[:session][:email]} não encontrado"
      end
      redirect_to entrar_path
    end
  end

  def destroy
    reset_session
    flash[:success] = 'Logout com sucesso'
    redirect_to root_path
  end
end
