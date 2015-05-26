class AddUserIdToPoolReservations < ActiveRecord::Migration
  def change
    add_column :pool_reservations, :user_id, :integer
  end
end
