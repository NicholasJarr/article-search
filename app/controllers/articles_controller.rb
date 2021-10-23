class ArticlesController < ApplicationController
  def index
    # TODO: Limit article title size
    @query = params[:query]
    if not @query.nil? and not @query.empty?
      SearchSaver.new(@query, request.remote_ip).save
    end

    @articles = @query ? Article.has_keyword(@query) : Article.all
    
    respond_to do |format|
      format.html
      format.json { render json: @articles }
    end
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
