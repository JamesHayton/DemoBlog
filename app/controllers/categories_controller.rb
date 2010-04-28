class CategoriesController < ApplicationController

 before_filter :get_category_by_name, :only => [:show, :edit, :update, :destroy]
 before_filter :get_posts_by_category, :only => [:show]

	def new
    @category = Category.new
    authorize! :create, @category
  end

  def create
    @category = Category.new
    #authorize! :create, @category
    create_category_params
    
    if @category.save
      redirect_to root_path
      flash[:notice] = "Your Category Has Been Created."
    end
  end
  
  def edit
    authorize! :update, @category
  end
  
  def update
    authorize! :update, @category
    create_category_params
    
    if @category.save
      redirect_to root_path
      flash[:notice] = 'Your Category Has Been Updated.  Woohoo!'
    end
  end

  def show
    authorize! :read, @category
    @categories = Category.by_name
  end
  
  def destroy
    @category.destroy
    authorize! :destroy, @category
    redirect_to root_path
    flash[:notice] = 'Your Category Has Been Deleted.'
  end

  private
  
  def create_category_params
    category_params = params["category"]
    @category.name = category_params["name"]
  end
  
  def get_category_by_name
    @category = Category.by_slug(:key => params[:id]).first
  end
  
  def get_posts_by_category
    @posts = Post.by_category(:key => @category.name)
  end
  
end
