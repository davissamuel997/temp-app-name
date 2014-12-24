class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  authorize_resource

	def index
		@users = User.all
	end

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			redirect_to @user, notice: 'User was successfully created.'
		else
			redirect_to action: 'new'
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to @user, notice: 'User was successfully updated.'
		else
			redirect_to action: 'edit'
		end
	end

	def destroy
		@user.destroy
		redirect_to users_path, notice: 'User was successfully destroyed.'
	end

	private

		def set_user
			@user = User.find(params[:id])
		end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name,
      														 :last_name,
      														 :user_name,
      														 :email_address
      														)
    end

end