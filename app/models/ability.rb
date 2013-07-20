class Ability
  include CanCan::Ability

  def initialize(user)

      user ||= User.new # guest user (not logged in)
      if user.admin? or user.producer?
        can :manage, :all
      end

      if user.writer?
        can :manage, Question
      end

  end
end
