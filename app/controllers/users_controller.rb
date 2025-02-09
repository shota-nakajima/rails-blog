class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        flash.now[:notice] = "ユーザーの新規登録に成功しました。"
        redirect_to root_path
    else
        flash.now[:alert] = "ユーザーの新規登録に失敗しました。"
        render :new
    end
  end

  private
  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
