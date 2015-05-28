class Doctor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :surveys

  validates :first_name, :last_name, presence: true

  after_create :generate_short_url

  def to_s
    [first_name, last_name].join(' ')
  end

  def regenerate_short_url
    generate_short_url
  end

  private

  def generate_short_url
    url = Googl.shorten(
        "https://doctorq.herokuapp.com/home/init?doc=1",
        '8.8.8.8',
        'AIzaSyBsbvtt9wI2JNPW7IW-rg6ht0wVoLrWPsM')
    self.short_url = url.short_url
    self.save
  end
end
