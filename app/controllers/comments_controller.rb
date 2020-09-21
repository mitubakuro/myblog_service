class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to "/articles/#{@comment.article.id}", notice: 'コメントを投稿しました'
    else
      render "/articles/#{params[:article_id]}"
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
    if comment.destroy
      redirect_to "/articles/#{comment.article.id}", notice: 'コメントを削除しました'
    else
      redirect_to "/articles/#{comment.article.id}", notice: 'コメントを削除できませんでした'

    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(article_id: params[:article_id])
  end
end
