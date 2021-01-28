# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user&.admin?
      can :manage, :all
      can :access, :rails_admin
    end
  end
end
