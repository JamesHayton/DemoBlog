class CommentsController < ApplicationController

	def new
    @comment = Comment.new
    authorize! :create, @comment
  end

  def create
    @comment = Comment.new
    authorize! :create, @comment
    create_comment_params
    
    if @comment.save
      redirect_to :back
      flash[:notice] = "Your Comment Has Been Created."
    end
  end

  def destroy
    get_comment_by_id
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to :back
    flash[:notice] = "Your Comment Has Been Deleted."
  end

  private 
 
  def create_comment_params
    comment_params = params["comment"]
    @comment.body = comment_params["body"]
    @comment.name = comment_params["name"]
    @comment.email = comment_params["email"]
    @comment.website = comment_params["website"]
    #@comment.post_id = comment_params[@post.id]
    @comment.temp_post_id = comment_params["temp_post_id"]
  end

  def get_comment_by_id
    @comment = Comment.by__id(:key => params[:id]).first
  end
  
end
