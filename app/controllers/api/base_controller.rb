module Api
  class BaseController < ApplicationController
    include Response

    rescue_from ActiveRecord::RecordNotFound do
      error_response("Record not found or invalid/missing api_key", :not_found)
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
