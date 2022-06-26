module Api
  class TrainOperatorsController < Api::BaseController
    def create
      @train_operator = TrainOperator.new(train_operator_params)

      return success_response(@train_operator) if @train_operator.save
      error_response(@train_operator.errors.full_messages)
    end

    def index
      @train_operators = TrainOperator.all
    end

    private

    def train_operator_params
      params.permit(:name)
    end
  end
end
