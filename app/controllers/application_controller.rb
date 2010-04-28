class ApplicationController < ActionController::Base
  
  helper :all
  #protect_from_forgery
  
  before_filter :set_current
  
  # Temporary Hack Cuz I Am Too Lazy To Refactor Right Now!
  before_filter :get_all_categories

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "Access Denied.  You Do Not Have Permission To Do That. "
    redirect_to root_path
  end

  #private
    
  def set_current
    Thread.current[:env] = Rails.env.to_sym
    svr = CouchRest::Server.new(APP_CONFIG['couch_db_location'])
    couch_db = CouchRest::Database.new(svr, "demoblog")
    Thread.current[:blog_db] = couch_db
  end

  def get_all_categories
    @categories = Category.by_name
  end

end
