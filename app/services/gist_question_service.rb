class GistQuestionService
  # ROOT_ENDPOINT = 'https://api.github.com'
  # ACCESS_TOKEN = 'a10f0bfc91db6eade171c25c0951f9bf7c975371'

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || Octokit::Client.new(access_token: ENV['ACCESS_TOKEN'])
    # @client = client || Octokit::Client.new(access_token: ACCESS_TOKEN)
  end
  
  def call
    @client.create_gist(gist_params)
  end

  private

  def gist_params
    {
      description: I18n.t('.description', title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end
  
  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end