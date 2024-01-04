class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :eth_address
      t.string :eth_nonce

      t.timestamps
    end
  end
end
