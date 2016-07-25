class Diario < Cefetphb
  has_one :aluno_diario
  belongs_to :disciplina
  belongs_to :curso
  belongs_to :sala
end
