class ApplicationController < ActionController::Base
  #before_filter :authenticate_user!
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.default_message = "Você não tem autorização para acessar esta pagina"
    redirect_to root_url
  end
  
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.role == "aluno"
      aluno_root_url
    elsif resource_or_scope.role == "professor"
      servidore_root_url
    elsif resource_or_scope.role == "coordenacao_pedagogica"
      coordenacao_pedagogica_root_url
    else
      super
    end
  end
end
