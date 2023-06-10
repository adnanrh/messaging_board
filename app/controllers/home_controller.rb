class HomeController < ApplicationController
  before_action :validate_user_signed_in

  def index
  end

  private

  def validate_user_signed_in
    redirect_to new_user_session_path unless current_user
  end
end
