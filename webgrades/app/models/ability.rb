class Ability
	include CanCan::Ability
	
	def initialize(user)
		user ||= User.new
		if user.role == "coordenacao_pedagogica"
			can :manage, :all
		
		elsif user.role == "coordenador_de_curso"
			can :read, [consulta_area, consulta_turma, consulta_aluno]
			can :manage, [mensagens]
	
		elsif user.role == "professor"
			can :read, [consulta_turma, consulta_aluno]
			can :manage, [mensagens]
		
		elsif user.role == "responsavel"
			can :read, [consulta_aluno]
			can :manage, [mensagens]
	
		elsif user.role == "aluno"
			can :read
			can :manage
		end
	end
end
