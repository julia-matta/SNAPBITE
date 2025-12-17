class PostReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def recommend
    reaction = @post.post_reactions.find_or_initialize_by(user: current_user)
    reaction.reaction_type = :recommend
    reaction.save!
    redirect_back fallback_location: timeline_path
  end

  def not_recommend
    reaction = @post.post_reactions.find_or_initialize_by(user: current_user)
    reaction.reaction_type = :not_recommend
    reaction.save!
    redirect_back fallback_location: timeline_path
  end

  def destroy
    @post.post_reactions.where(user: current_user).destroy_all
    redirect_back fallback_location: timeline_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
