class AddConfirmableToDevise < ActiveRecord::Migration
  def self.up
    add_column :doctors, :confirmation_token, :string
    add_column :doctors, :confirmed_at,       :datetime
    add_column :doctors, :confirmation_sent_at , :datetime
    add_column :doctors, :unconfirmed_email, :string

    add_index  :doctors, :confirmation_token, :unique => true
  end
  def self.down
    remove_index  :doctors, :confirmation_token

    remove_column :doctors, :unconfirmed_email
    remove_column :doctors, :confirmation_sent_at
    remove_column :doctors, :confirmed_at
    remove_column :doctors, :confirmation_token
  end
end
