class CommentsController < ApplicationController
  include PublicActivity::Common
  filter_resource_access

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.where('user_id = ?', current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new :task_id => params[:task_id], :user_id => current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])

    if params[:complete]
      @comment.task.complete = true
      @comment.task.save
    end

    respond_to do |format|
      if @comment.comment.length == 0 || @comment.save
        PublicActivity::Activity.create key: 'comment.create', trackable: @comment, company_id: @comment.task.project.company_id, project_id: @comment.task.project_id, task_id: @comment.task_id, owner: current_user
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        PublicActivity::Activity.create key: 'comment.update', trackable: @comment, company_id: @comment.task.project.company_id, project_id: @comment.task.project_id, task_id: @comment.task_id, owner: current_user
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  def download
    redirect_to @comment.attachment.expiring_url(10)
  end
end
