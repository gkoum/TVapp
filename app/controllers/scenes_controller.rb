class ScenesController < ApplicationController
  before_action :set_scene, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: [:destroy, :index]
  # GET /scenes
  # GET /scenes.json
  def index
    @disable_navp = true
    @areas = Area.all
    if params[:search]
      @scenes = Scene.search(params[:search]).order("created_at DESC")
    else
      @scenes = Scene.all.order('created_at DESC')
    end
  end

  # GET /scenes/1
  # GET /scenes/1.json
  def show
    @scene = Scene.find(params[:id])
    @disable_nav = true
    @disable_navp = true
    @user = @scene.user
    if @scene.scene_type == 4
      @post_feed_items = @user.post_feed.where(category: ["news","events"]).paginate(page: params[:page], :per_page => 5)
      @post1 = @scene.microposts.find_by(area_id: 8)
      
      
      @postlogo = @scene.microposts.find_by(area_id: 14)

      @postcarousel1 = @scene.microposts.where(area_id: 9).first
      @postcarousel2 = @scene.microposts.where(area_id: 9).second
      @postcarousel3 = @scene.microposts.where(area_id: 9).third

      @postthreecolumn1 = @scene.microposts.where(area_id: 10).first
      @postthreecolumn2 = @scene.microposts.where(area_id: 10).second
      @postthreecolumn3 = @scene.microposts.where(area_id: 10).third

    elsif @scene.scene_type == 3
      @post1 = @scene.microposts.find_by(area_id: 8)
      @post2 = @scene.microposts.where(area_id: 9).first
      @post3 = @scene.microposts.where(area_id: 9).second
      @post4 = @scene.microposts.where(area_id: 9).third
      @post5 = @scene.microposts.find_by(area_id: 7)
      @post6 = @scene.microposts.find_by(area_id: 10)
    elsif @scene.scene_type == 2
      @post1 = @scene.microposts.find_by(area_id: 2)
      @postticker1 = @scene.microposts.where(area_id: 1).first
      @postticker2 = @scene.microposts.where(area_id: 1).second
      @postticker3 = @scene.microposts.where(area_id: 1).third
    elsif @scene.scene_type == 1
      @post1 = @scene.microposts.find_by(area_id: 12)
      @postcarousel1 = @scene.microposts.where(area_id: 11).first
      @postcarousel2 = @scene.microposts.where(area_id: 11).second
      @postcarousel3 = @scene.microposts.where(area_id: 11).third
    elsif @scene.scene_type == 6
      @postcarousel1 = User.find_by(admin: true).microposts.where(scene_id: [2]).first
      @postcarousel2 = User.find_by(admin: true).microposts.where(scene_id: [2]).second
      @postcarousel3 = User.find_by(admin: true).microposts.where(scene_id: [2]).third
      @postthreecolumn1 = User.find_by(admin: true).microposts.where(scene_id: [2]).fourth
      @postthreecolumn2 = User.find_by(admin: true).microposts.where(scene_id: [2]).fifth
      @postthreecolumn3 = User.find_by(admin: true).microposts.where(scene_id: [2]).last
    elsif @scene.scene_type == 7
      @post1 = @scene.microposts.find_by(area_id: 13)
    else
      redirect_to edit_scene_path(@scene.id)
    end
  end

  def search
    @disable_nav = true
    
    @scene = Scene.find_by_name(params[:name])
    @user = @scene.user
    if @scene.scene_type == 4
      @post_feed_items = @user.post_feed.where(category: ["news","events"]).paginate(page: params[:page], :per_page => 5)
      @post1 = @scene.microposts.find_by(area_id: 8)
      
      
      @postlogo = @scene.microposts.find_by(area_id: 14)

      @postcarousel1 = @scene.microposts.where(area_id: 9).first
      @postcarousel2 = @scene.microposts.where(area_id: 9).second
      @postcarousel3 = @scene.microposts.where(area_id: 9).third

      @postthreecolumn1 = @scene.microposts.where(area_id: 10).first
      @postthreecolumn2 = @scene.microposts.where(area_id: 10).second
      @postthreecolumn3 = @scene.microposts.where(area_id: 10).third

    elsif @scene.scene_type == 3
      @post1 = @scene.microposts.find_by(area_id: 8)
      @post2 = @scene.microposts.where(area_id: 9).first
      @post3 = @scene.microposts.where(area_id: 9).second
      @post4 = @scene.microposts.where(area_id: 9).third
      @post5 = @scene.microposts.find_by(area_id: 7)
      @post6 = @scene.microposts.find_by(area_id: 10)
    elsif @scene.scene_type == 2
      @post1 = @scene.microposts.find_by(area_id: 2)
      @postticker1 = @scene.microposts.where(area_id: 1).first
      @postticker2 = @scene.microposts.where(area_id: 1).second
      @postticker3 = @scene.microposts.where(area_id: 1).third
    elsif @scene.scene_type == 1
      @post1 = @scene.microposts.find_by(area_id: 12)
      @postcarousel1 = @scene.microposts.where(area_id: 11).first
      @postcarousel2 = @scene.microposts.where(area_id: 11).second
      @postcarousel3 = @scene.microposts.where(area_id: 11).third
    else
      redirect_to edit_scene_path(@scene.id)
    end
  end

  # GET /scenes/new
  def new
    @disable_navp = true
    @scene = Scene.new
  end

  # GET /scenes/1/edit
  def edit
    @disable_navp = true
    @scene = Scene.find(params[:id])
    
    @user = @scene.user
    @scene_type = @scene.scene_type
    @scenes = Scene.where("scene_type = ?", @scene_type)
    @scene_feed_items = @user.scene_feed.paginate(page: params[:page], :per_page => 5)
    @post_feed_items = @scene.post_feed.paginate(page: params[:page], :per_page => 5)
    @area_feed_items = @scene.area_feed.where("number = ?", @scene_type).paginate(page: params[:page], :per_page => 5)
  end

  # POST /scenes
  # POST /scenes.json
  def create
    @disable_navp = true
    @scene = Scene.new(scene_params)

    respond_to do |format|
      if @scene.save
        format.html { redirect_to edit_scene_path(@scene.id), notice: 'Scene was successfully created.' }
        format.json { render action: 'show', status: :created, location: @scene }
      else
        format.html { render action: 'new' }
        format.json { render json: @scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenes/1
  # PATCH/PUT /scenes/1.json
  def update
    respond_to do |format|
      if @scene.update(scene_params)
        format.html { redirect_to edit_scene_path(@scene.id), notice: 'Scene was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scene.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenes/1
  # DELETE /scenes/1.json
  def destroy
    @scene.destroy
    respond_to do |format|
      format.html { redirect_to scenes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scene
      @scene = Scene.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scene_params
      params.require(:scene).permit(:name, :url, :user_id, :scene_type)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
