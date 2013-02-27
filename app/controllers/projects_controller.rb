class ProjectsController < ApplicationController
  filter_resource_access

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.with_permissions_to(:read)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new :company_id => params[:company_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    params[:project][:start_date] = DateTime.strptime(params[:project][:start_date], '%m/%d/%Y').strftime('%Y/%m/%d')
    params[:project][:end_date] = DateTime.strptime(params[:project][:end_date], '%m/%d/%Y').strftime('%Y/%m/%d')
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to :back, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    params[:project][:start_date] = DateTime.strptime(params[:project][:start_date], '%m/%d/%Y').strftime('%Y/%m/%d')
    params[:project][:end_date] = DateTime.strptime(params[:project][:end_date], '%m/%d/%Y').strftime('%Y/%m/%d')
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def calendar
    headers['Content-Type'] = 'text/calendar'
    project = Project.find(params[:id])
    user = User.find_by_access_token(params[:token])
    if (current_user == nil && (params[:token] == nil || user == nil)) || user.company_id != project.company.id
      flash[:error] = "unauthorized access"
      head :unauthorized
    end
    @calendar = Project.find(params[:id]).ical
    respond_to do |format|
      format.ics
    end
  end
end
