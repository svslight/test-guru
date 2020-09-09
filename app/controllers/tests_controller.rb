class TestsController < ApplicationController

  before_action :authenticate_user!

  def index    
    @tests = Test.with_category.order("categories.title ASC")
  end

  def start
    @test = Test.find(params[:id])

    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test), notice: t('.begin', title:@test.title)
  end

  def clean
    TestPassage.all.each{ |rec| rec.destroy  }
    BadgesUser.all.each{ |rec| rec.destroy  }
  end
end
