module Api
  class PackagesController < Api::BaseController
    before_action :load_parcel_owner, only: %i[create status withdraw]

    def create
      line_id = Line.find_by!(name: params[:line]).id
      @package = @parcal_owner.packages.new(package_params.merge(line_id: line_id))

      return success_response(@package) if @package.save
      error_response(@package.errors.full_messages)
    end

    def status
      @package = @parcal_owner.packages.find(params[:id])

      success_response({ status: @package.status })
    end

    def withdraw
      @package = @parcal_owner.packages.find(params[:id])

      if @package.pending?
        @package.withdraw!
        return success_response({ success: true })
      else
        return error_response("Cannot withdraw a package that has status is #{@package.status}")
      end
    end

    private

    def package_params
      params.permit(:weight, :volume)
    end
  end
end
