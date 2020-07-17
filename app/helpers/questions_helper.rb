module QuestionsHelper  
  def question_header(question)
    if question.new_record?
      "Создание нового вопроса (#{@test.title}) теста."
    else
      "Редактирование вопроса '#{question.test.title}' теста."
    end
  end
end
