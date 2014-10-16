class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: [:show, :edit, :update, :destroy, :index]
  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
    
    @scene = @area.scene
    
    
    @post_feed_items = @scene.post_feed.paginate(page: params[:page], :per_page => 5)
    
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        @scene=@area.scene
        format.html { redirect_to edit_scene_path(@scene.id), notice: 'Area was successfully created.' }
        format.json { render action: 'show', status: :created, location: @area }
      else
        format.html { render action: 'new' }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        @scene=@area.scene
        @user = @scene.user
        format.html { redirect_to @user, notice: 'Area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:scene_id, :number, :place, :dimension, :area_type)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
