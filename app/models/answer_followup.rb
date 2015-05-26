class AnswerFollowup < ActiveRecord::Base
  belongs_to :answer
  has_and_belongs_to_many :questions

  def self.following_questions(answer_id)
    followup = self.where(answer_id: answer_id).first

    followup && followup.question_ids || []
  end
end
