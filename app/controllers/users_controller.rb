class UsersController < ApplicationController
  before_action :require_logged_in_user, only: [:edit, :update]
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Cadastro realizado com sucesso'
      sign_in(@user)
      redirect_to root_url
    else
      flash[:alert] = @user.errors.full_messages.join('. ')
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Usuário atualizado com sucesso!'
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
