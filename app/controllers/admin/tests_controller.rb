class Admin::TestsController < Admin::BaseController

  before_action :find_tests, only: %i[index update_inline]
  before_action :find_test, only: %i[show edit update update_inline destroy start]

  def index
  end

  def show
    @questions = @test.questions
  end

  def new
    @test = Test.new
  end
  
  def edit
  end
  
  def create
    @test = current_user.authored_tests.new(test_params)
    
    if @test.save
      redirect_to admin_tests_path, notice: t('.success', first_name: @test.author.first_name, last_name: @test.author.last_name )
    else
      render :new
    end
  end
  
  def update
    if @test.update(test_params)
      redirect_to admin_tests_path, notice: t('.success')
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path, notice: t('.success')
    else
      render :index
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path, notice: t('.success')
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_tests
    @tests = Test.all
  end
  
  def find_test
    @test = Test.find(params[:id])
  end
end
