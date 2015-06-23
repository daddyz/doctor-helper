class Survey < ActiveRecord::Base

  serialize :result, Hash

  belongs_to :doctor

  scope :unshown, ->{ where(shown: false) }
  scope :for_notification, ->{ where(notified: false) }

  default_scope ->{ order('shown ASC, created_at ASC') }

  def self.add_from_session(params)
    doctor = Doctor.find(params['doctor'])
    doctor.surveys.create(
      queue_number: params['queue'],
      result: params['answers']
    )
  end

  def self.notifications_for_doctor(doctor_id, with_update = false)
    notifications = Doctor.find(doctor_id).surveys.for_notification
    notifications.update_all(notified: true) if with_update
    notifications.map {|s| s.to_s }
  end

  def to_s
    I18n.t('models.surveys.taken_at', { number: queue_number,
                                        time: created_at.strftime('%H:%M'),
                                        date: created_at.strftime('%d.%m')})
  end

  def red_alert?
    Answer.where(id: result.values).where(red_alert: true).present?
  end

  def result_data
    Hash[result.map { |q, a| [ Question.find(q).to_s, Answer.find(a).to_s ] }]
  end
end
