class Aluno < Cefetphb
  has_many :users, :as => :associable
  has_many :aluno_diarios
  has_many :observations
  belongs_to :curso
  belongs_to :pessoa
end
