class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, Attachment
      can :manage, [Question, Answer], { user: user }
      can :create, Comment
    end
    can :read, :all
  end
end
