class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:alert] = "User created!"
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to users_path }
      end
    else
      flash.now[:error] = "User already exists!"
      respond_to do |format|
        format.turbo_stream
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      if @user.previous_changes.except(:updated_at).empty?
        flash[:notice] = "No changes were made"
      else
        flash[:notice] = "Document was successfully modified"
      end
      respond_to do |format|
        format.html { redirect_to users_path }
      end
    else
      flash.now[:error] = "Invalid inputs"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "Document was successfully destroyed"
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :role)
  end

end
