# frozen_string_literal: true

class TicketTransfer < ApplicationRecord
  belongs_to :ticket
  belongs_to :from_team, class_name: "Team"
  belongs_to :to_team,   class_name: "Team"
  belongs_to :moved_by,  class_name: "User"
end
