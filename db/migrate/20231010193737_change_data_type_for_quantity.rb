class ChangeDataTypeForQuantity < ActiveRecord::Migration[7.0]
  def up
  	change_column :recipe_foods, :quantity, :integer, using: 'quantity::integer', :default => 0
  end

  def down
  	change_column :recipe_foods, :quantity, :string
  end
end
