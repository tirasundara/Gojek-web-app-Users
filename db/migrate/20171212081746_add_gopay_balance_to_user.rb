class AddGopayBalanceToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gopay_balance, :decimal, precision: 8, scale: 2, null: false, default: 0.0
  end
end
