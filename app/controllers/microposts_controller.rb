class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      @scene=@micropost.scene
      redirect_to edit_scene_path(@scene.id)
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def new
    @micropost = Micropost.new
    @user=User.first
    @scene_feed_items = @user.scene_feed.paginate(page: params[:page], :per_page => 5)
    @post_feed_items = @user.post_feed.paginate(page: params[:page], :per_page => 5)
  end

  def destroy
    Micropost.find(params[:id]).destroy
    flash[:success] = "Post deleted."
    
    
    redirect_to current_user
  end

  def show
    @user = Micropost.find(params[:id]).user_id
    @micropost  = @user.microposts.find(params[:id])
  end

  def edit
    @micropost  = Micropost.find(params[:id])
    
  end

  def update
    @micropost  = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "Micropost updated"
      @scene=@micropost.scene
      redirect_to edit_scene_path(@scene.id)
      
    else
      render 'edit'
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :image, :category, :text, :scene_id, :area_id)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end