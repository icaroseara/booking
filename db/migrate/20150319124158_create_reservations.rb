class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :booked_at
      t.references :user, index: true
      t.integer :status

      t.timestamps
    end
  end
end
