class ChangePriceDatatype < ActiveRecord::Migration[5.2]

  def change
    change_column :listings, :price, 'USING price::integer'
  end
end


