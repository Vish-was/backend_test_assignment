class ApplicationController < ActionController::API
  protected

  def record_not_found
    Rails.logger.info "Record not found"
    render json: {message: 'record not found'}, status: 404
  end
end
