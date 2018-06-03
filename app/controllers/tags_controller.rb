class TagsController < ApplicationController
  before_action :verify_is_admin, :only => [:destroy]
  def	show
		@tag	=	Tag.find(params[:id])
  end
  def index
    @tags = Tag.all
  end
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to tags_path
  end
  private
  def verify_is_admin
  (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end

end
