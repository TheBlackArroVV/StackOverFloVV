class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, Attachment
      can [:create, :update, :destroy], [Question, Answer], user: user
      can :choose_best, Answer, user: user
      can :create, Comment
      can [:like, :dislike, :unvote], [Question, Answer]
      cannot [:like, :dislike, :unvote], [Question, Answer], user: user
    end
    can :read, :all
  end
end
