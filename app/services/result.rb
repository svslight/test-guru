class Result
#   attr_accessor :response

  def initialize(client)
    @response = client.last_response
  end

  def success?
    !!@response
  end
end
