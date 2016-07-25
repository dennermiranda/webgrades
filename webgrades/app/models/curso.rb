class Curso < Cefetphb
  has_many :diarios
  has_many :notifications
  has_many :alunos
end
