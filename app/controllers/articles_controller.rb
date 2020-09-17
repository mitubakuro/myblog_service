class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :top]
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :stop_direct_url, only:[:edit, :update, :destroy]

  def top
  end

  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(4)
    if params[:tag_name]
      @articles = Article.tagged_with("#{params[:tag_name]}").order(created_at: :desc)
    end
  end

  def show
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

  def stop_direct_url
    redirect_to root_path unless current_user.id == @article.user_id && request.referrer != nil
  end

end
