# frozen_string_literal: true

class CreateTicketTransfers < ActiveRecord::Migration[8.1]
  def change
    create_table :ticket_transfers do |t|
      t.references :ticket, null: false, foreign_key: true
      t.references :from_team, null: false, foreign_key: { to_table: :teams }
      t.references :to_team, null: false, foreign_key: { to_table: :teams }
      t.references :moved_by, null: false, foreign_key: { to_table: :users }
      t.string :reason

      t.timestamps
    end
  end
end
