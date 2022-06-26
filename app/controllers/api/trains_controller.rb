module Api
  class TrainsController < Api::BaseController
    before_action :load_train_operator, only: %i[create index withdraw status]

    def create
      @train = @train_operator.trains.new(train_params)

      return success_response(@train) if @train.save
      error_response(@train.errors.full_messages)
    end

    def index
      @trains = @train_operator.trains.activated
    end

    def withdraw
      @train = @train_operator.trains.activated.find(params[:id])

      # TODO: check this train is in service or not

      @train.update(active: false)
    end

    def status
      @train = @train_operator.trains.activated.find(params[:id])
      success_response({ status: "pending" })
    end

    private

    def train_params
      params.permit(:max_weight, :max_volume, :cost, lines: [])
    end
  end
end
