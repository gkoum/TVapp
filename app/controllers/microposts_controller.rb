class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  
  def index
    @user = curerent_user
    @post_feed_items = @user.post_feed.paginate(page: params[:page], :per_page => 5)
    @area_feed_items = @user.area_feed.where("number = ?", @scene_type).paginate(page: params[:page], :per_page => 5)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
     
      if current_user.scenes.find_by_scene_type(4)
        redirect_to current_user

      else
        @scene=@micropost.scene
        redirect_to edit_scene_path(@scene.id)
      end
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def new
    @micropost = Micropost.new
    @user=User.first
    @scene = Scene.find_by_id(params[:id])
    @areas = Area.all
    @scene_feed_items = @user.scene_feed.paginate(page: params[:page], :per_page => 5)
    @post_feed_items = @user.post_feed.paginate(page: params[:page], :per_page => 5)
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    flash[:success] = "Post deleted."
    if (@micropost.scene != nil)
      @scene = @micropost.scene
      @id = @scene.id
      redirect_to edit_scene_path(@id)
    else
      redirect_to current_user
    end
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