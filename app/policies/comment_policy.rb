# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    return false unless TicketPolicy.new(user, record.ticket).show?
    record.internal? ? user.member_of?(record.ticket.team) : true
  end
end
