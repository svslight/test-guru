class Result

  def initialize(client)
    @response = client.last_response
  end

  def success?
    @response.status == 200 ? true : false
  end
end
