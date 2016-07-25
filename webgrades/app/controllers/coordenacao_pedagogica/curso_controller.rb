class CoordenacaoPedagogica::CursoController<ApplicationController
  before_filter :authenticate_user!
  def index
    @diarios = Diario.all
  end

  def show
    @diarios = Diario.all
  end
end
