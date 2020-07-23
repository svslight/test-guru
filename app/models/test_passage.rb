class TestPassage < ApplicationRecord
  PERCENT_CORRECT_ANSWERS = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: [ :create, :update ]
  
  def completed?
    current_question.nil?
  end
  
  def accept!(answers_ids)
    self.correct_question += 1 if correct_answer?(answers_ids)
    save!
  end

  def number_question
    completed_questions.size + 1 
  end
  
  def percent_correct_answers
    correct_question.to_f / test.questions.size * 100
  end

  def success?
    percent_correct_answers >= PERCENT_CORRECT_ANSWERS
  end

  def total_questions
    test.questions.size
  end

  private

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def before_validation_set_first_question
    if current_question.nil?
      self.current_question = test.questions.first if test.present?
    else
      self.current_question = remaining_questions.first
    end
  end

  def remaining_questions
    test.questions.order(:id).where('id > ?', current_question.id)
  end
  
  def completed_questions
    test.questions.order(:id).where('id < ?', current_question.id)
  end
end
