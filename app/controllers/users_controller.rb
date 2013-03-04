class UsersController < ApplicationController
  def index
    @users = User.group('company_id, id').order('real_name asc')
    hash = {}
    @users.each do |user|
      hash[user.company] ? hash[user.company] << user : hash[user.company] = [user]
    end
    @users = hash

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users}
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

	puts 'what?'
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :users, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
