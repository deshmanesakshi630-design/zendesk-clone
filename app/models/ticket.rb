# frozen_string_literal: true

class Ticket < ApplicationRecord
  enum :status,   { open: 0, pending: 1, resolved: 2, closed: 3 }
  enum :priority, { low: 0, normal: 1, high: 2, urgent: 3 }

  belongs_to :requester, class_name: "User"
  belongs_to :team
  belongs_to :assignee, class_name: "User", optional: true
  has_many :comments, dependent: :destroy
  has_many :ticket_transfers, dependent: :destroy

  validates :subject, presence: true
  validate :assignee_must_be_in_team

  def transfer_to(new_team, by:, reason: nil)
    unless by.member_of?(team)
      errors.add(:base, "Only the current team can transfer this ticket"); return false
    end
    if new_team == team
      errors.add(:base, "Ticket is already with #{team.name}"); return false
    end
    transaction do
      ticket_transfers.create!(from_team: team, to_team: new_team, moved_by: by, reason: reason)
      update!(team: new_team, assignee: nil)
    end
    true
  end

  private

  def assignee_must_be_in_team
    return if assignee.nil? || assignee.member_of?(team)
    errors.add(:assignee, "must be a member of #{team.name}")
  end
end
