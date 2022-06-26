module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json_response
    JSON.parse(response.body).with_indifferent_access
  end
end
