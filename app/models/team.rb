# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :tickets, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: true
end
