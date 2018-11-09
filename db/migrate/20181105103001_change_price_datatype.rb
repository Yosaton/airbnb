class ChangePriceDatatype < ActiveRecord::Migration[5.2]

  def change
  end
  change_column :listings, :price, 'integer USING CAST(price AS integer)'
end


