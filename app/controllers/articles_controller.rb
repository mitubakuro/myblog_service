class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :top, :new_guest]
  before_action :find_article, only: [:show, :edit, :update, :destroy, :release, :unrelease]
  before_action :stop_direct_url, only: [:show, :edit, :update, :destroy, :release, :unrelease]

  def top
  end

  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(12)
    if params[:tag_name]
      flash.now[:notice] = "##{params[:tag_name]}" + 'の記事一覧'
      @articles = Article.tagged_with(params[:tag_name].to_s).order(created_at: :desc)
      @articles = @articles.page(params[:page])
    end
  end

  def show
    @comment = current_user.comments.new
    @comments = @article.comments.includes(:user).order(created_at: :desc)
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
    @articles = @articles.page(params[:page])
  end

  def release
    @article.released! unless @article.released?
    redirect_to edit_article_path(@article), notice: 'この投稿を公開しました'
  end

  def unrelease
    @article.unreleased! unless @article.unreleased?
    redirect_to edit_article_path(@article), notice: 'この投稿を非公開にしました'
  end

  def ranking
    @articles_ranking =Article.find(Like.group(:article_id).order('count(article_id) desc').limit(8).pluck(:article_id))
  end

  def new_guest
    user = User.find_or_create_by!(nickname: "ゲストユーザー", email: 'guest@example.com', firstname: "げすと", lastname: "ゆーざー", birthday: "2000-10-10") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :image, :tag_list).merge(user_id: current_user.id)
  end

  def stop_direct_url
    redirect_to root_path, notice: '直リンクは禁止です' unless current_user.id == @article.user_id || !request.referrer.nil?
  end
end
