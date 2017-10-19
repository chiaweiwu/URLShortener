class Tagging < ApplicationRecord
  validates :url_id, :tag_id, presence: true


  has_many :shortened_urls,
  class_name: :ShortenedUrl,
  primary_key: :id,
  foreign_key: :url_id

  has_many :tag_topics,
  class_name: :TagTopic,
  primary_key: :id,
  foreign_key: :tag_id

end
