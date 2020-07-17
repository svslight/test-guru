class QuestionsController < ApplicationController
    
  before_action :find_test, only: [:new, :create]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found
  
  # GET /tests/id/questions
  # def index
  # end

  # GET /questions/id
  def show
  end

  # GET /questions/id/edit
  def edit
  end

  # GET /tests/id/questions/new
  def new
   @question = @test.questions.new       
  end
    
  # POST /tests/id/questions
  def create
    @question = @test.questions.new(question_params)    
  
    if @question.save
      redirect_to test_path(@test)
    else
      render :new
    end
  end
  
  # PATCH /questions/id/edit
  def update
    if @question.update(question_params)
      redirect_to test_path(@question.test)
    else
      render :edit
    end
  end
  
  def destroy
    @question.destroy

    redirect_to test_path(@question.test)
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
    @questions = @test.questions
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render plain: 'Вопрос не найден'
  end

end
