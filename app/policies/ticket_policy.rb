class TicketPolicy < ApplicationPolicy

	def show?
		user.try(:admin?) || record.project.has_member?(user)
	end
	
  class Scope < Scope
    def resolve
      scope
    end
  end
end
