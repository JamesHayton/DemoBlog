class Comment < CouchRest::ExtendedDocument
  
  extend ActiveModel::Naming
  extend CouchConfig::DatabaseFromThread

  property :body
  property :status
  property :name
  property :email
  property :website
  property :post_id
  property :temp_post_id
  
  view_by :temp_post_id
  view_by :_id

  timestamps!

  def generate_post_id
    "test"
  end
          
end
