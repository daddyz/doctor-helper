class Question < ActiveRecord::Base
  has_many :answers
  has_and_belongs_to_many :answer_followups

  validates :body, presence: true

  def answers_hash
    Hash[ answers.map { |a| [a.id, a.to_s] } ]
  end

  def with_answers
    {
      id: id,
      q: to_s,
      answers: answers_hash
    }
  end

  def to_s
    body
  end
end
