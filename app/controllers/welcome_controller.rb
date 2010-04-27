class WelcomeController < ApplicationController
  
  #before_filter :get_all_categories
  #caches_action :index, :expires_in => 5.minutes#, :if => Proc.new { |controller| !controller.params[:no_cache]} #url?no_cache=true :layout => false,  

  def index
    @posts = Post.by_created_at(:limit => "10")
  end

  def about
  end
  
  def contact
  end

  def archives
  end
  
  private
  
  def get_all_categories
    @categories = Category.by_name
  end

end
