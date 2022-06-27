module Api
  class BaseController < ApplicationController
    include Response

    rescue_from StandardError do |e|
      error_response(e.message, :bad_request)
    end

    protected

    def load_train_operator
      @train_operator = TrainOperator.find_by!(api_key: request.headers[:Authorization])
    end

    def load_parcel_owner
      @parcal_owner = Customer.find_by!(api_key: request.headers[:Authorization])
    end
  end
end
