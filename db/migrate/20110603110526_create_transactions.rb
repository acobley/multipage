class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.string :tid
      t.references :user
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
