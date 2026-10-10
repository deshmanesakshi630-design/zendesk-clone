# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: "User"
  validates :body, presence: true
  scope :visible_to, ->(user) { user.internal? ? all : where(internal: false) }
end
