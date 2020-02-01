class UsersController < ApplicationController
	before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
  end

  def index
  	@users = User.all
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
end