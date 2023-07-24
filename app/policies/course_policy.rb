class CoursePolicy < ApplicationPolicy
  # class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   # def resolve
  #   #   scope.all
  #   # end
  # end

  
  def index?
    user.instructor?
  end

  def show?
     user.instructor?
  end

  def create?
     user.instructor?
  end

  def new?
     user.instructor?
  end

  def update?
     user.instructor?
  end

  def destroy?
     user.instructor?
  end


end
