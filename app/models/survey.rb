class Survey < ActiveRecord::Base

  serialize :result, Hash

  belongs_to :doctor

  scope :unshown, ->{ where(shown: false) }

  default_scope ->{ order('shown ASC, created_at ASC') }

  def self.add_from_session(params)
    doctor = Doctor.find(params['doctor'])
    doctor.surveys.create(
      queue_number: params['queue'],
      result: params['answers']
    )
  end

  def red_alert?
    Answer.where(id: result.values).where(red_alert: true).present?
  end

  def result_data
    Hash[result.map { |q, a| [ Question.find(q).to_s, Answer.find(a).to_s ] }]
  end
end
