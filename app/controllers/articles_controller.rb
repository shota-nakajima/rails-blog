class ArticlesController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :destroy]
  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(5)

    if params[:search]
      @articles = Article.search(params[:search]).order(created_at: :desc).page(params[:page]).per(5)
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to root_path, notice: "記事を削除しました"
    else
      flash.now[:danger] = "削除に失敗しました"
      render 'show'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    article.update(article_params)
    redirect_to article
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def ensure_correct_user
    article = Article.find(params[:id])
    if article.user_id != current_user.id
      redirect_to article
    end
  end
end
