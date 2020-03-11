class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def profile
    @user = current_user
    @itineraries=current_user.itineraries

  end

  def update_profile
    @user = current_user
    @user.update(user_params)
    redirect_to profile_path, notice: 'user updated!'
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end

end
