class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: %i[create destroy]

  # see all invitations and friends
  def index; end

  # send friend request
  def create
    if @friendship.nil?
      @request = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])

      if @request.save
        flash.notice = 'Request sent!'
        redirect_back(fallback_location: root_path)
      else
        render :new
      end
    else
      flash.notice = 'There is already a friend request pending for this user!'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @user = User.find(params[:user_id])
    current_user.confirm_friend(current_user, @user)
    flash.notice = 'Request Accepted!'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_friendship
    @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id) ||
                  Friendship.find_by(user_id: current_user.id, friend_id: params[:user_id])
  end
end
