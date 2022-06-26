module Api
  class CustomersController < Api::BaseController
    def create
      @customer = Customer.new(customer_params)

      return if @customer.save
      error_response(@customer.errors.full_messages)
    end

    private

    def customer_params
      params.permit(:name)
    end
  end
end
