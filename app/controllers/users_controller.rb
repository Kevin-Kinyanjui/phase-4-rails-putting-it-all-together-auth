class UsersController < ApplicationController

    def show
        # in ApplicationController
        if current_user
            render json: current_user
        else
            render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
      
    private
      
    def user_params
        params.require(:user).permit(:username, :password, :image_url, :bio)
    end     
end
