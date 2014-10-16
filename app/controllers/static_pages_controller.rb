class StaticPagesController < ApplicationController
  require 'net/http'
  def home
    if signed_in?
      @user=current_user
      @micropost  = User.find_by(admin: true).microposts.where(category: ["news","events"]).build
      @post_feed_items = User.find_by(admin: true).post_feed.where(category: ["news","events"]).paginate(page: params[:page], :per_page => 5)
      else
      @post_feed_items = User.find_by(admin: true).post_feed.where(category: ["news","events"]).paginate(page: params[:page], :per_page => 5)
    end
  end

  def results
    if signed_in?
      @user=current_user
      @micropost  = User.find_by(admin: true).microposts.where("category = ?", "results").build
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "results").paginate(page: params[:page], :per_page => 5)
    end
  end

  def blog
    if signed_in?
      @user=current_user
      @micropost  = User.find_by(admin: true).microposts.where("category = ?", "blog").build
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "blog").paginate(page: params[:page], :per_page => 5)
    end
  end

  def tips
    
      @user=current_user
      @micropost  = User.find_by(admin: true).microposts.where("category = ?", "tips").build
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "tips").paginate(page: params[:page], :per_page => 5)
    
  end

  def galery
    if signed_in?
      @user=current_user
      @micropost  = User.find_by(admin: true).microposts.where("category = ?", "gallery").build
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "gallery").paginate(page: params[:page], :per_page => 5)
    else
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "gallery").paginate(page: params[:page], :per_page => 5)
    end
  end

  def contact
  end

  def tzakpot
    @lottoxml= Net::HTTP.get(URI.parse('http://media.opap.gr/Swf/LottoTzakPot.xml'))
    @lotto=Hash.from_xml(@lottoxml)["kerdi"]
    @res 
    @micropost = Micropost.find_by(id: 60)
  end

  def news
    if signed_in?
      @user=current_user
      @micropost  = User.find_by(admin: true).microposts.where("category = ?", "news").build
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "news").paginate(page: params[:page], :per_page => 5)
    else
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "news").paginate(page: params[:page], :per_page => 5)
    end
  end

  def myshop
  end

  def events
    if signed_in?
      @user=current_user
      @micropost  = User.find_by(admin: true).microposts.where("category = ?", "events").build
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "events").paginate(page: params[:page], :per_page => 5)
    else
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "events").paginate(page: params[:page], :per_page => 5)
    end
  end

  def lucky
    if signed_in?
      @user=current_user
      @micropost  = User.find_by(admin: true).microposts.where("category = ?", "lucky").build
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "lucky").paginate(page: params[:page], :per_page => 5)
    else
      @post_feed_items = User.find_by(admin: true).post_feed.where("category = ?", "lucky").paginate(page: params[:page], :per_page => 5)
    end
  end


end
