# class FriendshipsController < ApplicationController
#   def create
#     friend = User.find(params[:friend_id])
#     current_user.friends << friend
#     redirect_back fallback_location: timeline_path
#   end

#   def destroy
#     friend = User.find(params[:id])
#     current_user.friends.delete(friend)
#     redirect_back fallback_location: timeline_path
#   end
# end

class FriendshipsController < ApplicationController
  def create
    followed = User.find(params[:friend_id])
    current_user.active_friendships.create!(followed: followed)
    redirect_back fallback_location: user_path(followed)
  end

  def destroy
    friendship = Friendship.find_by!(id: params[:id], user_id: current_user.id)
    friendship.destroy
    redirect_back(fallback_location: users_path)
  end
end
