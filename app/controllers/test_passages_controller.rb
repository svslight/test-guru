class TestPassagesController < ApplicationController
  require 'result'

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
  end

  def result    
    if @test_passage.success?
      @test_passage.update(passed: true)
      @badges = BadgeService.new(@test_passage).get_badges
      if @badges.present?
        current_user.badges.push(@badges)
        flash[:notice] = t('.badge')
      end
    end
  end


  def update
    redirect_to @test_passage,
      notice: "Требуется ответить, чтобы перейти к следующему вопросу!!!" and return if !params[:answer_ids].present?

    @test_passage.accept!(params[:answer_ids])    
    
    render :show and return if !@test_passage.completed?
  
    redirect_to result_test_passage_path(@test_passage)

    TestsMailer.completed_test(@test_passage).deliver_now

  end

  def gist
    question = @test_passage.current_question
    request_to_gist = GistQuestionService.new(question)
    result = request_to_gist.call

    response = Result.new(request_to_gist.client)

    flash_options = if response.success?
      url = result.html_url
      current_user.gists.create(question_id: question.id, gist_url: url )
      { notice: t('.success', gist_url: url) }
    else
      { alert: t('.failure') }
    end

    redirect_to @test_passage, flash_options
  end

  private
  
  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
