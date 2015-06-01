class Doctor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :surveys

  validates :first_name, :last_name, presence: true

  after_create :generate_short_url
  after_create :generate_qr_code

  def to_s
    [first_name, last_name].join(' ')
  end

  def regenerate_short_url
    generate_short_url
  end

  def direct_url
    "https://doctorq.herokuapp.com/home/init?doc=#{self.id}"
  end

  private

  def generate_qr_code
    require 'rqrcode_png'

    qr = RQRCode::QRCode.new(self.direct_url, size: 6, level: :h)
    png = qr.to_img
    png.resize(150, 150).save(
      Rails.root.join('public', 'qrcodes', "doc#{self.id}.png")
    )
  end

  def generate_short_url
    url = Googl.shorten(
        self.direct_url,
        '8.8.8.8',
        'AIzaSyBsbvtt9wI2JNPW7IW-rg6ht0wVoLrWPsM')
    self.short_url = url.short_url
    self.save
  end
end
