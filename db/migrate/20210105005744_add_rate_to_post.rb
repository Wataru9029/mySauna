class AddRateToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :rate, :float, null: false, default: 0
  end
end
