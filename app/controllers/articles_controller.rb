class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :authorize_user!, only: %i[edit update destroy]

  def set_article
    @article = Article.find(params[:id])
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  def authorize_user!
    unless @article.username == current_user
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def index
    @articles = Article.order(created_at: :desc)
    #@articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.username = current_user

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end

