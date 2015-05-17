class AddLockableToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :failed_attempts, :integer, default: 0
    add_column :doctors, :unlock_token, :string
    add_column :doctors, :locked_at, :datetime
  end
end
