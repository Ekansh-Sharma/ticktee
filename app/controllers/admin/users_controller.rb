class Admin::UsersController < Admin::BaseController
	before_action :authorize_admin!
  before_action :set_user, only: [:edit,:show,:update,:destroy]
  def index
  	@users = User.order(:email)
  end
  def new
  	@user = User.new
  end

  def edit
  end

  def update
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    if @user.update_attributes(params[:user], :as => "admin")
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render action: :edit
    end
  end

  def show
  end

  def create
  	params = user_params.dup
  	params[:password_confirmation] = params[:password]
  	@user = User.new(params)
  	if @user.save
  		flash[:notice] = "User has been created."
    	redirect_to admin_users_path
  	else
  		flash.now[:alert] = "User has not been created."
  		render :action => "new"
  	end
  end
  private
  def user_params
  	params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
