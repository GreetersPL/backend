# Basic api controller
class ApiController < ApplicationController
  respond_to :json, :xml
  before_action :set_cors_headers
  after_action :set_cors_headers

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    response = { errors: [error] }
    respond_to do |format|
      format.json { render json: response, status: :unprocessable_entity }
    end
  end

  rescue_from(ActionController::UnpermittedParameters) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.params] = ['parameter is required']
    response = { errors: [error] }
    respond_to do |format|
      format.json { render json: response, status: :unprocessable_entity }
    end
  end

  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
