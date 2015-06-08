class AddQrCodeToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :qr_code, :binary
  end
end
