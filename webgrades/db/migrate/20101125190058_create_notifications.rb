class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.text :conteudo
      t.string :assunto
      t.integer :curso_id
      t.integer :sala_id

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
