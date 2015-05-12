class DeviseCreateReceptionists < ActiveRecord::Migration
  def change
    create_table(:receptionists) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps
    end

    add_index :receptionists, :email,                unique: true
    # add_index :receptionists, :reset_password_token, unique: true
    # add_index :receptionists, :confirmation_token,   unique: true
    add_index :receptionists, :unlock_token,         unique: true
  end
end
