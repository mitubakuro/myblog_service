class LikesController < ApplicationController
  before_action :set_article

  def create
    Like.create(user_id: current_user.id, article_id: params[:id])
  end

  def destroy
    Like.find_by(user_id: current_user.id, article_id: params[:id]).destroy
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

end
