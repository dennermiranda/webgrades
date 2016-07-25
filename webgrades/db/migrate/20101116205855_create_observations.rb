class CreateObservations < ActiveRecord::Migration
  def self.up
    create_table :observations do |t|
      t.text :conteudo
      t.string :observation_type
      t.string :user_role
      t.integer :aluno_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :observations
  end
end
