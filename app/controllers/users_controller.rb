class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def new
  	@user = User.new
  end

  def index
    
      if params[:search]
        @users = User.search(params[:search]).order("created_at DESC")
      else
        @users = User.all.order('created_at DESC')
      end
    
    
  end

  def show
    if signed_in?
  		@user = User.find(params[:id])
      
    	@scene_feed_items = @user.scene_feed.paginate(page: params[:page], :per_page => 5)
      
    else
    	@user = User.find(params[:id])
    end
  end

  def edit
  	
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    @admin = User.find_by(admin: true)
    respond_to do |format|
      if @user.save
        
        flash[:success] = "User created"
        
 
        format.html { redirect_to(@user) }
        format.json { render json: @user, status: :created, location: @admin }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        
      end
    end
    end

  def update
    
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :address, :shopnumber, :phone, :mobile, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
