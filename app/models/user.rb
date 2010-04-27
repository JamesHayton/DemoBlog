class User < CouchRest::ExtendedDocument

  devise :database_authenticatable, :registerable, :timeoutable

  extend DeviseOverrides::SessionSerializer
  extend ActiveModel::Naming
  extend CouchConfig::DatabaseFromThread

  property :username
  property :slug
  property :email
  property :time_zone, :default => "Pacific Time (US & Canada)"
  property :password_salt
  property :encrypted_password

  view_by :slug
  view_by :member_name
  view_by :email
  view_by :_id

  view_by :created_at, :descending => true

  timestamps!

  before_save :downcase_email
  before_save :generate_slug_from_username

  def generate_slug_from_username
    if self.new_document?
      self.slug = User.clean_username(username)
    end
  end

  def self.clean_username(the_slug)
    the_slug.downcase.gsub(/[^a-z0-9]/,'-').squeeze('-').gsub(/^\-|\-$/,'')
  end
  
  def downcase_email
    self.email = email.downcase
  end

  #Devise Override For Finding User When Logging In
  def self.find_for_authentication(conditions)
    User.by_email(:key => conditions['email']).first 
  end
                 
end


