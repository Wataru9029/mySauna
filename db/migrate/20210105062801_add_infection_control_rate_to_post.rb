class AddInfectionControlRateToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :infection_control_rate, :float
  end
end
