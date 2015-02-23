class TicketPolicy < ApplicationPolicy

	def show?
		user.try(:admin?) || record.project.has_member?(user)
	end

	def update?
		user.try(:admin?) || record.project.has_manager?(user) || (record.project.has_editor?(user) && record.author == user)
	end

	def destroy?
		user.try(:admin?) || record.project.has_manager?(user)
	end

	def create?
		user.try(:admin?) || record.project.has_manager?(user) || record.project.has_editor?(user)
	end

  def change_state?
    user.try(:admin?) || record.project.has_manager?(user)
  end

  def tag?
    destroy?
  end

  def tag?
    user.try(:admin?) || record.project.has_manager?(user)
  end
	
  class Scope < Scope
    def resolve
      scope
    end
  end
end