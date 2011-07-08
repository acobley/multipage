class CreateAmazons < ActiveRecord::Migration
  def self.up
    create_table :amazons do |t|
      t.string :Apid

      t.timestamps
    end
  end

  def self.down
    drop_table :amazons
  end
end
