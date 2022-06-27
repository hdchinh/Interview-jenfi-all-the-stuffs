module Api
  class PostMastersController < Api::BaseController
    def process_packages
      line = Line.find_by!(name: process_packages_params[:line])

      return error_response("The line is unavailable.") if line.unavailable?

      result = ProcessPackagesService.new(line).perform

      if result
        success_response(
          "Packages is being transported on the train id #{result.id} belongs to train operator #{result.train_operator.name}."
        )
      else
        error_response("Don't have any packages to process.")
      end
    end

    def process_packages_params
      params.permit(:line)
    end
  end
end
