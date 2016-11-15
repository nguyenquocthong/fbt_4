class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
      can :manage, Category
      can :manage, Place
    else
      can :read, :all
      can [:new, :create], Review
      can [:edit, :update, :destroy], Review do |review|
        review.user == user
      end
    end
  end
end
