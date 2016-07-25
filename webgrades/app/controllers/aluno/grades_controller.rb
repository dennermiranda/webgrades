class Aluno::GradesController < ApplicationController
	#load_and_authorize_resource
  before_filter :authenticate_user!
  
	def index
    if current_user.role == "aluno" || current_user.role == "responsavel"
      @aluno =Aluno.find(current_user.associable_id)
      @pessoa = Pessoa.find(@aluno.pessoa_id)
      @aluno_diario = AlunoDiario.where(:aluno_id => @aluno.id).includes(:diario => [:curso, :disciplina])
    else
      flash[:alert] = "Sem autorização"
      redirect_to root_path
    end
	end
end
