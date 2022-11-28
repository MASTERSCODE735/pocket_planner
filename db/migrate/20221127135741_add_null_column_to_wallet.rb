class AddNullColumnToWallet < ActiveRecord::Migration[6.0]
    def change
        change_column_null(:wallets, :in_amount, true)
        change_column_null(:wallets, :out_amount, true)
    end
end
