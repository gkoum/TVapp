class ScenesController < ApplicationController
  before_action :set_scene, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: [:destroy, :index]
  # GET /scenes
  # GET /scenes.json
  def index
    @scenes = Scene.all
  end

  # GET /scenes/1
  # GET /scenes/1.json
  def show
    @scene = Scene.find(params[:id])
    @disable_nav = 1
    @user = @scene.user
    if @scene.scene_type == 4
      @post1 = @scene.microposts.find_by(area_id: 8)
      @post2 = @scene.microposts.find_by(area_id: 91)
      @post3 = @scene.microposts.find_by(area_id: 92)
      @post4 = @scene.microposts.find_by(area_id: 93)
      @post5 = @scene.microposts.find_by(area_id: 7)
      @post6 = @scene.microposts.find_by(area_id: 10)
    elsif @scene.scene_type == 3
      @post1 = @scene.microposts.find_by(area_id: 8)
      @post2 = @scene.microposts.find_by(area_id: 91)
      @post3 = @scene.microposts.find_by(area_id: 92)
      @post4 = @scene.microposts.find_by(area_id: 93)
      @post5 = @scene.microposts.find_by(area_id: 7)
      @post6 = @scene.microposts.find_by(area_id: 10)
    elsif @scene.scene_type == 2
      @post1 = @scene.microposts.find_by(area_id: 20)
      @postticker1 = @scene.microposts.find_by(area_id: 11)
      @postticker2 = @scene.microposts.find_by(area_id: 12)
      @postticker3 = @scene.microposts.find_by(area_id: 13)
    elsif @scene.scene_type == 1
      @post1 = @scene.microposts.find_by(area_id: 12)
      @post2 = @scene.microposts.find_by(area_id: 111)
      @post3 = @scene.microposts.find_by(area_id: 112)
      @post4 = @scene.microposts.find_by(area_id: 113)
    else
      redirect_to edit_scene_path(@scene.id)
    end
  end

  # GET /scenes/new
  def new
    @scene = Scene.new
  end

  # GET /scenes/1/edit
  def edit
    @scene = Scene.find(params[:id])
    
    @user = @scene.user
    @post = @user.microposts.first
    @scene_type = @scene.scene_type
    @scenes = Scene.where("scene_type = ?", @scene_type)
    @scene_feed_items = @user.scene_feed.paginate(page: params[:page], :per_page => 5)
    @post_feed_items = @scene.post_feed.paginate(page: params[:page], :per_page => 5)
    @area_feed_items = @scene.area_feed.where("number = ?", @scene_type).paginate(page: params[:page], :per_page => 5)
  end

  # POST /scenes
  # POST /scenes.json
  def create
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
