# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record) = (@user, @record = user, record)

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope) = (@user, @scope = user, scope)

    def resolve = scope.none
  end
end
