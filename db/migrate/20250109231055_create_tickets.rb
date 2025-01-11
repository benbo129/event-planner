class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :user
      t.string :category
      t.integer :event_id

      t.timestamps
    end
    add_index :tickets, :event_id
  end
end
