class ArticlesController < ApplicationController
  def index
    @query = params[:query]
    if not @query.nil? and not @query.empty?
      Search.create query: @query, ip_address: request.remote_ip
    end

    @articles = @query ? Article.has_keyword(@query) : Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    if @article.save
      flash[:success] = 'Created article'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def article_params
      params.require(:article).permit :title, :body
    end
end
