class Servidore::DisciplinaController < ApplicationController
	#load_and_authorize_resource
  before_filter :authenticate_user!

  def show
    @aluno_diario = AlunoDiario.where(:diario_id => params[:id]).includes(:aluno => [:pessoa])
    @user_aluno = User.where(:role => 'aluno')
    @user_responsavel = User.where(:role => 'responsavel')
  end
end
