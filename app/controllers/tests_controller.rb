class TestsController < ApplicationController

  before_action :authenticate_user!

  def index
    @tests = Test.with_questions
  end

  def start
    @test = Test.find(params[:id])

    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test), notice: t('.begin', title:@test.title)
  end
end
