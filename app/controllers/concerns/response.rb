module Response
  def success_response(object = {}, status = :ok)
    render json: { data: object }, status: status
  end

  def error_response(error_msg = {}, status = :bad_request)
    render json: { message: error_msg }, status: status
  end
end
