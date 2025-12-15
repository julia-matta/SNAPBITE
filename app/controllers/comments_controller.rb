class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_back fallback_location: timeline_path, notice: "Comentário enviado!"
    else
      redirect_back fallback_location: timeline_path, alert: "Não foi possível salvar o comentário."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
