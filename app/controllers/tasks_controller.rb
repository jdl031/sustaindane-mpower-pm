class TasksController < ApplicationController
  filter_resource_access :collection => [:calendar]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.where('owner_id = ?', current_user.id).group('project_id, id').order('complete asc, due asc')
    hash = {}
    @complete = 0
    @incomplete = 0
    @tasks.each do |task|
      hash[task.project] ? hash[task.project] << task : hash[task.project] = [task] if task.complete==(params[:complete]=='1')
      @complete += 1 if task.complete? 
      @incomplete += 1 if not task.complete?
    end
    @tasks = hash

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new :project_id => params[:project_id], :creator_id => current_user.id, :owner_id => current_user.id, :complete => false

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    params[:task][:due] = DateTime.strptime(params[:task][:due], '%m/%d/%Y').strftime('%Y/%m/%d')
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to :back, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    params[:task][:due] = DateTime.strptime(params[:task][:due], '%m/%d/%Y').strftime('%Y/%m/%d')
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def calendar
    headers['Content-Type'] = 'text/calendar'
    user = User.find_by_access_token(params[:token])
    if current_user == nil && (params[:token] == nil || user == nil)
      flash[:error] = "unauthorized access"
      head :unauthorized
    end
    tasks = Task.where('owner_id=?', user.id)
    @calendar = Icalendar::Calendar.new
    tasks.each do |task|
      @calendar.add task.ical_event
    end
    respond_to do |format|
      format.ics
    end
  end
end
