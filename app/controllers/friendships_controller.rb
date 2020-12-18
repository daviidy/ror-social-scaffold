class FriendshipsController < ApplicationController
  # see all invitations and friends
  def index; end

  # send friend request
  def create
    @friendship = current_user.friendships.new(user_id: current_user.id, friend_id: params[:user_id])

    if @friendship.save
      flash.notice = 'Request sent!'
      redirect_back(fallback_location: root_path)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:user_id])
    current_user.confirm_friend(@user)
    flash.notice = 'Request Accepted!'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:user_id])
    @friendship = current_user.inverse_friendships.where('user_id = ?', @user.id).first
    @friendship.destroy
    flash.notice = 'Request rejected!'
    redirect_back(fallback_location: root_path)
  end
end
