Webgrades::Application.routes.draw do
  resources :posts

  resources :topics

  resources :forums

  resources :messages

  resources :notifications

  resources :observations

  devise_for :users
  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
  namespace 'aluno' do 
    resources :grades, :only => [:index]
    root :to => 'grades#index'
  end
  namespace 'servidore' do 
    resources :disciplina, :only => [:show]  
    resources :curso, :only => [:index, :show]
    root :to => 'curso#index'
  end
  namespace 'coordenacao_pedagogica' do
    resources :curso, :only =>[:index, :show]
    resources :disciplina, :only => [:show]
    root :to => 'curso#index'
  end
  resources :user, :controller => "user"
  
  #match 'inicio', :controller => 'user', :action => 'index'
  root :to => 'home#index'
  #match 'grades/aluno' => 'grades#aluno'
  #match 'grades/professor' => 'grades#professor'
  #match 'grades/turma' => 'grades#turma'
  #diario_path => /grades/turma

end
