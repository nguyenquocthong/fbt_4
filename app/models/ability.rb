class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
      can :manage, Category
      can :manage, Place
      can :manage, Tour
    elsif user.user?
      can :read, Tour

      can [:read, :new, :create], Review
      can [:edit, :update, :destroy], Review do |review|
        review.user == user
      end
      can :create, Like
      can :destroy, Like do |like|
        like.user == user
      end

      can [:read, :new, :create], Booking
      can [:destroy], Booking do |booking|
        booking.user == user && booking.waiting_pay?
      end

      can :manage, :payment

      can [:read, :new, :create], Comment
      can [:edit, :update, :destroy], Comment do |comment|
        comment.user == user
      end
    else
      can :read, Tour
      can :read, Review
    end
  end
end
