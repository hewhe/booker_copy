class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]
  def show
  	@user = User.find(params[:id])
  	@booknew = Book.new
  end

  def index
  	@users = User.all
  	@booknew = Book.new
  	#@user = User.find(params[:id])これはまちがい、indexにparameterのidは送られてこない
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
	@user = User.find(params[:id])
	@user.id = current_user.id
	if @user.update(user_params)
	flash[:notice] = "successfully Updated"
	redirect_to user_path(@user.id)
	else
		render :edit
	end
  end

	private
		def user_params
			params.require(:user).permit(:name, :introduction, :profile_image)
		end

		def correct_user
			user = User.find(params[:id])
			if current_user.id != user.id
				redirect_to user_path(current_user.id)
			end
		end
end