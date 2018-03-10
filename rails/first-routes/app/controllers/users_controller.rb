class UsersController < ApplicationController
  def index
    render plain: "I'm in the index action!"
  end

  def create
    user = User.new(params.require(:user).permit(:user_attributes_here))
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end
end
