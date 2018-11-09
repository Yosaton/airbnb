class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :check_in
      t.date :check_out
      t.string :host
    end
    add_reference :reservations , :user , index:true
    add_reference :reservations , :listing , index:true
  end
end
