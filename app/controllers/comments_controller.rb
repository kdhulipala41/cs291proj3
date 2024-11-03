class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params.merge(commenter: current_user))
    
    if @comment.save
      redirect_to article_path(@article), notice: "Comment added successfully."
    else
      redirect_to article_path(@article), alert: "Unable to add comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
