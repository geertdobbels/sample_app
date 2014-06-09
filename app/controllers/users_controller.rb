class UsersController < ApplicationController
   before_filter :signed_in_user, only: [:index, :edit, :update] # here all site visitors still can see individual users when
   														 # directly writing the users url in the browser.  if this is not
   														 # wantes, add :show restriction in signed_in_user filter
   before_filter :correct_user, only: [:edit, :update]
   before_filter :admin_user,   only: :destroy
  def new
  	@user = User.new
  end
  def index
  	@users = User.paginate(page: params[:page], per_page: 10)
  end
  def show
	 @user = User.find(params[:id])
  end
  
  def create
	 @user = User.new(params[:user])
	 if @user.save
		sign_in @user
		flash[:success] = "Welcome to the sample app!"
		redirect_to @user
	 else
		render 'new'
	 end
  end
  def edit
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end
  def update
  	if @user.update_attributes(params[:user])
  		flash[:success] = "Profile updated"
  		sign_in @user
  		redirect_to @user
  	else
  		render 'edit'
  	end
  end
  private
  	def signed_in_user
  		redirect_to signin_path, notice: "Please sign in." unless signed_in?
  	end
  	def correct_user
  		@user = User.find(params[:id])
  		redirect_to(root_path) unless current_user?(@user)
  	end
  	def signed_in_user
  		unless signed_in?
  			store_location
  			redirect_to signin_path, notice: "Please sign in"
  		end
  	end
  	def correct_user
  		@user = User.find(params[:id])
  		redirect_to(root_path) unless current_user?(@user)
  	end
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
