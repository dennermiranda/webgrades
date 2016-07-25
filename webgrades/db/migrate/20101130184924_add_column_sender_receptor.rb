class AddColumnSenderReceptor < ActiveRecord::Migration
  def self.up
    add_column :messages, :sender_type, :string
    add_column :messages, :receiver_type, :string
  end

  def self.down
    
  end
end
