class Servidore::CursoController < ApplicationController
	#load_and_authorize_resource
  before_filter :authenticate_user!

  def index
    @professor = Servidore.find(current_user.associable_id)
  end

  def show
    @diario = Diario.where(:professor_id => current_user.associable_id, :curso_id => params[:id])
  end
end
