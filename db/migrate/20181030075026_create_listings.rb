class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :address
      t.string :price
      t.boolean :verification, default: false
      t.timestamps
    end
    add_reference :listings , :user , index:true
    change_column :listings, :price, :integer #change price from string to integer

  end
end

