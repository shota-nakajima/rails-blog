class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        flash[:notice] = "ユーザーの新規登録に成功しました。"
        redirect_to root_path
    else
        Rails.logger.debug("Validation errors: #{@user.errors.full_messages}")  # エラーメッセージをログに出力
        flash.now[:alert] = "ユーザーの新規登録に失敗しました。"
        render :new
    end
  end

  private
  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
