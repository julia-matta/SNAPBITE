class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    current_user.friends << friend
    redirect_back fallback_location: timeline_path
  end

  def destroy
    friend = User.find(params[:id])
    current_user.friends.delete(friend)
    redirect_back fallback_location: timeline_path
  end
end
