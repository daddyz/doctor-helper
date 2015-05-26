class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :answer_followups

  validates :question_id, :body, presence: true

  def to_s
    body
  end
end
