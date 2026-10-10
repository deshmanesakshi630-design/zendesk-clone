# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team
  validates :user_id, uniqueness: { scope: :team_id }
  validate { errors.add(:user, "must be internal") unless user&.internal? }
end
