class Visit < ApplicationRecord
  validates :short_url_id, :user_id, presence: true

  belongs_to :visitor,
  class_name: :User,
  primary_key: :id,
  foreign_key: :user_id

  belongs_to :url,
  class_name: :ShortenedUrl,
  primary_key: :id,
  foreign_key: :short_url_id

  def self.record_visit!(user, shortened_url)
    Visit.create(user_id: user.id, short_url_id: shortened_url.id)
  end
end
