class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, Project, user_id: user.id
    can :manage, Task, project: { user_id: user.id }
  end
end
