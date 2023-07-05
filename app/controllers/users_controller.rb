class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Cadastro realizado com sucesso'
      redirect_to root_url

    else
      flash[:alert] = @user.errors.full_messages.join('. ')
      redirect_to new_user_path
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
