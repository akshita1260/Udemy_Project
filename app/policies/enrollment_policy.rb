class EnrollmentPolicy < ApplicationPolicy
 def index?
    user.student?                    
  end

  def show?
     user.student?
  end

  def create?
     user.student?
  end

  def new?
     user.student?
  end

  def update?
     user.student?
  end

  def destroy?
     user.student?
  end
end
