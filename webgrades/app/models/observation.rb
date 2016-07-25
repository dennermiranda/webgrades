class Observation < ActiveRecord::Base
  belongs_to :user
  belongs_to :aluno
  OBSERVATION_TYPE = %w[interna externa]
  validates_presence_of :conteudo, :message => "-Preenchimento obrigatório"
end
