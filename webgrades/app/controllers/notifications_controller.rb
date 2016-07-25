class NotificationsController < ApplicationController
  # GET /notifications
  # GET /notifications.xml
  before_filter :authenticate_user!
  def index
    if current_user.role == 'coordenacao_pedagogica'
      @notifications = Notification.all
    elsif current_user.role == 'professor'
      @notifications = Notification.find_all_by_user_id(current_user.id)
    elsif current_user.role == 'aluno'
      @aluno = Aluno.find(current_user.associable_id)
      @notifications = Notification.all #find_all_by_sala_id_and_curso_id(@aluno.aluno_diarios.first.diario.sala.id, @aluno.aluno_diarios.first.diario.curso.id)

    else
      flash[:alert] = "Sem autorização"
      redirect_to root_path
    end
  end

  # GET /notifications/1
  # GET /notifications/1.xml
  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notification }
    end
  end

  # GET /notifications/new
  # GET /notifications/new.xml
  def new
    @notification = Notification.new
    @area = params[:area]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.xml
  def create
    @notification = Notification.new(params[:notification])

    respond_to do |format|
      if @notification.save
        format.html { redirect_to(@notification, :notice => 'Notificação postada com sucesso.') }
        format.xml  { render :xml => @notification, :status => :created, :location => @notification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @notification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notifications/1
  # PUT /notifications/1.xml
  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to(@notification, :notice => 'Notification was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.xml
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to(notifications_url) }
      format.xml  { head :ok }
    end
  end
end
