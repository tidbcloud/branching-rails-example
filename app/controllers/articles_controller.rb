class ArticlesController < ApplicationController
  before_action :authenticate_admin, except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to root_path, status: :see_other
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
      redirect_to root_path, status: :see_other
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

  def authenticate_admin
    authenticate_or_request_with_http_basic do |username, password|
      admin_username = ENV["ARTICLE_ADMIN_USERNAME"]
      admin_password = ENV["ARTICLE_ADMIN_PASSWORD"]

      admin_username.present? && admin_password.present? &&
        (ActiveSupport::SecurityUtils.secure_compare(username, admin_username) &
         ActiveSupport::SecurityUtils.secure_compare(password, admin_password))
    end
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
