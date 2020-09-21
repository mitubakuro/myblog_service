class CommentsController < ApplicationController

  def create
    @comment = current_user.comment.new(comment_params)
    if @comment.save
      redirect_to "/articles/#{comment.article.id}"
    else
      render "/articles/#{params[:article_id]}"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to "/articles/#{comment.article.id}"
    else
      
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(article_id: params[:article_id])
  end
end
