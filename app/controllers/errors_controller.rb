class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!

  def not_found
    respond_to do |format|
      format.html { render status: 404 }
    end

    skip_authorization
  end

  def internal_error
    respond_to do |format|
      format.html { render status: 500 }
    end

    skip_authorization
  end

  def unacceptable
    respond_to do |format|
      format.html { render status: 422 }
    end

    skip_authorization
  end
end
