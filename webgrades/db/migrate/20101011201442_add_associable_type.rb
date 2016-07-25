class AddAssociableType < ActiveRecord::Migration
  def self.up
	add_column :users, :associable_type, :string
	add_index :users, :associable_type
	add_index :users, :associable_id

  end

  def self.down
	remove_column :users, :comentavel_type
  end
end
