class Servidore < Cefetphb
  has_many :users, :as => :associable
  has_many :diarios, :foreign_key => :professor_id
  belongs_to :pessoa
end
