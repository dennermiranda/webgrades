class User < ActiveRecord::Base
  ROLES = %w[aluno professor responsavel coordenador_de_curso coordenacao_pedagogica]
  ASSOCIABLES = %w[aluno professor responsavel]
  has_many :observations
  has_many :notifications
  has_many :messages
  has_many :forums
  has_many :topics
  has_many :posts
  belongs_to :associable, :polymorphic => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :associable_id, :associable_type
  validate :aluno_servidor
  has_one :user
  validates_presence_of :associable_id, :message => "Digite um código válido"
  before_create :set_user_role

  def aluno_servidor
	if  role == 'coordenacao_pedagogica' ||  role == 'coordenador_de_curso'
	else
		if associable_type.blank?
			errors.add(:associable_type, "escolha um tipo de associação")
		else
		   if associable_type == "aluno" || associable_type == "responsavel" 
         if Aluno.where("id = ?", associable_id).blank?
			   errors.add(associable_type, "Matricula do aluno inválido ou inexistente")
         end
		    elsif Servidore.where("id = ?", associable_id).blank?
			   errors.add(associable_type, "Código inválido ou inexistente")
        end
		   end
		end
    if associable_type == 'aluno' || associable_type == 'responsavel'
      if User.where(:associable_type => 'aluno', :associable_id => associable_id).count > 0 && self.new_record?
        errors.add(associable_type, 'Matricula ja referenciada por outro usuario')
      end
      if User.where(:associable_type => 'responsavel', :associable_id => associable_id).count > 0
        errors.add(associable_type, 'Matricula ja referenciada por outro usuario')
      end
      end
    end
	
  

  def set_user_role
	if associable_type == 'aluno'  
		self.role = 'aluno'
  elsif associable_type == 'responsavel'
    self.role = 'responsavel'
  elsif associable_type == 'professor'
		self.role = 'professor'
	end
  end
end