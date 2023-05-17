class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  private

  def current_user
    AuthorizeApiRequest.new(request.headers).call.dig(:user)
  end
end
