class Result

  def initialize(client)
    @response = client.last_response
  end

  def success?    
    [200, 201, 202].include?(@response.status) ? true : false
  end
end
