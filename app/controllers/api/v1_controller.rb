module Api
  # Api version 1 controller
  class V1Controller < ApiController
    skip_before_action :verify_authenticity_token
  end
end
