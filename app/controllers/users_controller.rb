class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    unless signed_in?
    	@user = User.new
    else
      redirect_to root_path
    end
  end

  def create
    unless signed_in?
    	@user = User.new(user_params)
    	if @user.save
    		flash[:success] = "Welcom to the Sample App!"
    		redirect_to @user
    	else
    		render 'new'
    	end
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      #　更新に成功した場合
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user? user
      redirect_to root_path
    else
      user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    end
  end

  private

    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  # Before actions

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
