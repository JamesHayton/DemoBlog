class Category < CouchRest::ExtendedDocument
  
  extend ActiveModel::Naming
  extend CouchConfig::DatabaseFromThread
  
  property :slug
  property :name
  
  view_by :slug
  view_by :name

  timestamps!

  before_save :generate_slug_from_name

  def generate_slug_from_name
    if self.new_document?
      self.slug = Category.clean_name(name)
    end
  end

  def self.clean_name(the_name)
    the_name.downcase.gsub(/[^a-z0-9]/,'-').squeeze('-').gsub(/^\-|\-$/,'')
  end
          
end
