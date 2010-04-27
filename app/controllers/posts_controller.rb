class PostsController < ApplicationController
  
  before_filter :get_post_by_slug, :only => [:show, :edit, :update, :destroy]
  before_filter :get_all_categories, :only => [:show, :edit, :new]

  def show
    authorize! :read, @post
    @category = Category.by_name(:key => @post.category).first
    @comments = Comment.by_temp_post_id(:key => @post.id)
  end

	def new
    @post = Post.new
    authorize! :create, @post
    #@categories = Category.by_name
  end

  def edit
    authorize! :update, @post
    #@categories = Category.by_name
  end

  def update
    authorize! :update, @post
    create_post_params
    @post.save
    redirect_to post_path
    flash[:notice] = 'Your Post Has Been Updated.  Woohoo!'
  end

  def create
    @post = Post.new
    authorize! :create, @post
    create_post_params
    
    if @post.save
      redirect_to post_path({:id => @post.slug})
      flash[:notice] = 'Your Post Has Been Created.'
    end
  end

  def destroy
    authorize! :destroy, @post
    @post.destroy
    redirect_to root_path
    flash[:notice] = 'Your Post Has Been Deleted.'
  end

  private
  
  def create_post_params
    post_params = params["post"]
    @post.title = post_params["title"]
    @post.body = post_params["body"]
	  @post.status = post_params["status"]
    @post.category = post_params["category"]
    @post.user_id = current_user.id
  end
  
  def get_post_by_slug
    @post = Post.by_slug(:key => params[:id]).first
  end

  def get_all_categories
    @categories = Category.by_name
  end

  
end
