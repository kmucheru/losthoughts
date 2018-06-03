class ArticlesController < ApplicationController

  before_action :verify_is_admin, :only => [:new, :edit, :create, :destroy]

  def index
    @articles = Article.paginate(:page => params[:page],
     :per_page => 5).order("created_at DESC")
  end

  def show
    @article	=	Article.find(params[:id])
    @comment	=	Comment.new
    @comment.article_id	=	@article.id
  end

  def new
    @article	=	Article.new
  end

  def create
    @article	=	Article.new(article_params)
		@article.save
		redirect_to	article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def	edit
		@article	=	Article.find(params[:id])
  end

  def	update
		@article	=	Article.find(params[:id])
		@article.update(article_params)
      flash.notice	=	"Article	'#{@article.title}'	Updated!"
		redirect_to	article_path(@article)
  end

  def	article_params
		params.require(:article).permit(:title,	:body, :tag_list)
  end

  private
  def verify_is_admin
  (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end


end
