class TestPassagesController < ApplicationController
  require 'result'

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
  end

  def result
  end

  def update
    if  params[:answer_ids].present?
      @test_passage.accept!(params[:answer_ids])

      if @test_passage.completed?
        TestsMailer.completed_test(@test_passage).deliver_now
        redirect_to result_test_passage_path(@test_passage)
      else
        render :show
      end
    else
      redirect_to @test_passage, notice: "Чтобы перейти к следующему вопросу, требуется выбрать хотя бы на один ответ!"
    end

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
