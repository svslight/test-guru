class TestsController < ApplicationController

  before_action :authenticate_user!
  # before_action :find_test, only: %i[start]

  def index
    @tests = Test.all
  end

  def start
    @test = Test.find(params[:id])
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test), notice: t('.begin', title:@test.title )
  end

  # private

  # def find_test
  #   @test = Test.find(params[:id])
  # end 
end
