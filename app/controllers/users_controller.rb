class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  def index
    @user = User.all.paginate(page: params[:page], per_page: 2)
  end

 def show
  @user = User.find(params[:id])
  @microposts = @user.microposts.paginate(page: params[:page])
   #@user = User.new()

 end

 def new
  @user = User.new
 end
def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
            @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # Handle a successful save.
      #redirect_to user
   else
      render 'new'
    end
end
# @user = User.new(params[:user])
   # if @user.save
    #else
    #  render :action => 'new'
  #end
  #end
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
