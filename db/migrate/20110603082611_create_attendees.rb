class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.references :event
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :attendees
  end
end
