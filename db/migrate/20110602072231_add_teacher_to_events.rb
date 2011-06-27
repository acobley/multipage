class AddTeacherToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :teacher, :string
  end

  def self.down
    remove_column :events, :teacher
  end
end
