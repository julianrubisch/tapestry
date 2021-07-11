class AddMaxDurationToLists < ActiveRecord::Migration[6.1]
  def change
    add_column :lists, :max_duration, :float, default: 30.0
  end
end
