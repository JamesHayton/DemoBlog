class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new #Guest
    
    # Really Simple But Effective Way Of Making Sure The User Is Logged In.
    # Will Make This More Intelligent With Roles Later.
    if user && user.username != ""
      can :manage, :all
    else
      can :create, User
      can :read, Category
      can [:read, :create], Comment
      can :read, Post do |post|
      post.status == "Active"
      end
    end
  end

end
