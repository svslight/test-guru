class Answer < ApplicationRecord
  MAX_ANSWERS = 4
  belongs_to :question

  scope :correct, -> { where(correct: true) }

  validate :validate_max_answers, on: :create

  private

  def validate_max_answers
    errors.add(:answer, "Не больше #{MAX_ANSWERS} ответов") if Question.find(question_id).answers.count >= MAX_ANSWERS
  end
end
