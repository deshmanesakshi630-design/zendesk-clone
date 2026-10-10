# frozen_string_literal: true

class TicketPolicy < ApplicationPolicy
  def index?    = true
  def show?     = user.internal? || record.requester == user
  def create?   = true
  def update?   = user.member_of?(record.team)
  def transfer? = update?
  def assign?   = update?
  def status?   = update?

  class Scope < Scope
    def resolve = user.internal? ? scope.all : scope.where(requester: user)
  end
end
