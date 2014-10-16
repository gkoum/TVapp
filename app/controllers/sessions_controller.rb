class SessionsController < ApplicationController

  def new
  	if signed_in?
  	@user=current_user
  	@micropost  = current_user.microposts.build
    @post_feed_items = current_user.post_feed.paginate(page: params[:page])
    @scene_feed_items = current_user.scene_feed.paginate(page: params[:page])
    end
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:notice] = "You have been signed out."
    redirect_to root_url
  end
end
