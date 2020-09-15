class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :top]

  def top
  end

  def index
    @articles = Article.order(created_at: :desc)
    if params[:tag_name]
      @articles = Article.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: '作成できました'
    else
      flash.now[:notice] = 'タイトルと本文は必須です'
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: '更新できました'
    else
      flash.now[:notice] = 'タイトルと本文は必須です'
      render :edit
    end
  end

  def destroy
    if @article.destroy
      redirect_to root_path, notice: '削除に成功しました'
    else
      redirect_to root_path, notice: '削除できませんでした'
    end
  end

  def search
    @articles = Article.search(params[:keyword])
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :image, :tag_list).merge(user_id: current_user.id)
  end
end
