class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    gon.mountains = @user.mountains.distinct
  end
end
