# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum :role, { customer: 0, internal: 1 }

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :tickets, foreign_key: :requester_id, inverse_of: :requester, dependent: :destroy
  has_many :assigned_tickets, class_name: "Ticket", foreign_key: :assignee_id, dependent: :nullify
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true

  def member_of?(team) = internal? && teams.include?(team)
end
