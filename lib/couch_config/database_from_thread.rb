module CouchConfig::DatabaseFromThread
 
  def database 
    Thread.current[:blog_db]
  end
  
end
