class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true
  validates :short_url, :user_id, presence: true

  belongs_to :submitter,
  class_name: :User,
  primary_key: :id,
  foreign_key: :user_id

  has_many :visits,
  class_name: :Visit,
  primary_key: :id,
  foreign_key: :short_url_id

  has_many :visitors,
  -> { distinct }, # '->' means Proc.new
  through: :visits,
  source: :visitor


  def self.random_code
    short_url = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: short_url)
      short_url = SecureRandom.urlsafe_base64
    end
    short_url
  end

  def self.create!(user, long_url)
    ShortenedUrl.create(
      user_id: user.id, long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

    def num_clicks
      self.visits.count
    end

    def num_uniques
      self.visitors.count
      # self.visits.select(:user_id).distinct.count
    end

    def num_recent_uniques
      self.visitors.where("visits.updated_at >= '#{10.minutes.ago}'").size
    end

end
