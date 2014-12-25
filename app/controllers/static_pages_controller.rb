class StaticPagesController < ApplicationController
  require 'net/http'
  def home
    @disable_navp = true
    @postcarousel1 = User.find_by(admin: true).microposts.where(scene_id: [2]).first
    @postcarousel2 = User.find_by(admin: true).microposts.where(scene_id: [2]).second
    @postcarousel3 = User.find_by(admin: true).microposts.where(scene_id: [2]).third
    @postthreecolumn1 = User.find_by(admin: true).microposts.where(scene_id: [2]).fourth
    @postthreecolumn2 = User.find_by(admin: true).microposts.where(scene_id: [2]).fifth
    @postthreecolumn3 = User.find_by(admin: true).microposts.where(scene_id: [2]).last
    if signed_in?
      @user=current_user
      @micropost  = User.find_by(admin: true).microposts.where(category: ["news","events"]).build
      @post_feed_items = User.find_by(admin: true).post_feed.where(category: ["news","events"]).paginate(page: params[:page], :per_page => 6)
      else
      @post_feed_items = User.find_by(admin: true).post_feed.where(category: ["news","events"]).paginate(page: params[:page], :per_page => 6)
    end
  end

  def results
    @disable_nav = true
    if (params[:id] == nil)
      @scene = Scene.find_by_name(params[:name])
    else
      @scene = Scene.find_by_id(params[:id])
    end
    if signed_in?
      
      @user=@scene.user
      @micropost  = User.find_by(admin: true).microposts.where("category = ?", "results").build
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "results").paginate(page: params[:page], :per_page => 6)
    end
  end

  def blog
    @disable_nav = true
    if signed_in?
      @user=@scene.user
      @micropost  = User.find_by(admin: true).microposts.where("category = ?", "blog").build
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "blog").paginate(page: params[:page], :per_page => 6)
    end
  end

  def tips
    @disable_nav = true
    if (params[:id] == nil)
      @scene = Scene.find_by_name(params[:name])
    else
      @scene = Scene.find_by_id(params[:id])
    end
    if signed_in?
      @user=@scene.user
      @micropost  = @user.microposts.where("category = ?", "tips").build
      @post_feed_items = @user.post_feed.where("category = ?", "tips").paginate(page: params[:page], :per_page => 6)
    else
      @post_feed_items = @scene.user.post_feed.where("category = ?", "tips").paginate(page: params[:page], :per_page => 6)
    end
  end

  def galery
    @disable_nav = true
    if (params[:id] == nil)
      @scene = Scene.find_by_name(params[:name])
    else
      @scene = Scene.find_by_id(params[:id])
    end
    @user=@scene.user
    if signed_in?
      @micropost  = @user.microposts.where("category = ?", "gallery").build
      @post_feed_items = @user.post_feed.where("category = ?", "gallery").paginate(page: params[:page], :per_page => 6)
    else

      @post_feed_items = @user.post_feed.where("category = ?", "gallery").paginate(page: params[:page], :per_page => 6)
    end
  end

  def contact
    @disable_nav = true
    if (params[:id] == nil)
      @scene = Scene.find_by_name(params[:name])
    else
      @scene = Scene.find_by_id(params[:id])
    end
    @user=@scene.user
    @micropost  = User.find_by(admin: true).microposts.where(category: ["news","events"]).build
  end

  def tzakpot
    @disable_nav = true
    if (params[:id] == nil)
      @scene = Scene.find_by_name(params[:name])
    else
      @scene = Scene.find_by_id(params[:id])
    end
    @user=@scene.user
    @lottoxml= Net::HTTP.get(URI.parse('http://media.opap.gr/Swf/LottoTzakPot.xml'))
    @lotto=Hash.from_xml(@lottoxml)["kerdi"]
  end

  def news
    @disable_nav = true
    if (params[:id] == nil)
      @scene = Scene.find_by_name(params[:name])
    else
      @scene = Scene.find_by_id(params[:id])
    end
    @user=@scene.user
    if signed_in?
      @micropost  = @user.microposts.where("category = ?", "news").build
      @post_feed_items = @user.post_feed.where("category = ?", "news").paginate(page: params[:page], :per_page => 6)
    else
      @post_feed_items = @user.post_feed.where("category = ?", "news").paginate(page: params[:page], :per_page => 6)
    end
  end

  def myshop
    @disable_nav = true
    if (params[:id] == nil)
      @scene = Scene.find_by_name(params[:name])
    else
      @scene = Scene.find_by_id(params[:id])
    end
    @user=@scene.user
    @postcarousel1 = @scene.microposts.where(area_id: 9).first
    @postcarousel2 = @scene.microposts.where(area_id: 9).second
    @postcarousel3 = @scene.microposts.where(area_id: 9).third

    @postmyshop1  = @scene.microposts.where(area_id: 15).first
    @postmyshop2  = @scene.microposts.where(area_id: 15).second
    @postmyshop3  = @scene.microposts.where(area_id: 15).third
  end

  def events
    @disable_nav = true
    if (params[:id] == nil)
      @scene = Scene.find_by_name(params[:name])
    else
      @scene = Scene.find_by_id(params[:id])
    end
    @user=@scene.user
    if signed_in?
      @micropost  = @user.microposts.where("category = ?", "events").build
      @post_feed_items = @user.post_feed.where("category = ?", "events").paginate(page: params[:page], :per_page => 6)
    else
      @post_feed_items = @user.post_feed.where("category = ?", "events").paginate(page: params[:page], :per_page => 6)
    end
  end

  def lucky
    @disable_nav = true
    if (params[:id] == nil)
      @scene = Scene.find_by_name(params[:name])
    else
      @scene = Scene.find_by_id(params[:id])
    end
    @user=@scene.user
    if signed_in?
      @micropost  = @user.microposts.where("category = ?", "lucky").build
      @post_feed_items = @user.post_feed.where("category = ?", "lucky").paginate(page: params[:page], :per_page => 6)
    else
      @post_feed_items = @scene.user.post_feed.where("category = ?", "lucky").paginate(page: params[:page], :per_page => 6)

    end
  end


end
