class AddCapacity < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :capacity, :integer, :default => 0
  end
end
