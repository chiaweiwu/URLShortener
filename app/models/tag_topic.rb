class TagTopic < ApplicationRecord
  validates :tag, presence: true, uniqueness: true


  has_many :taggings,
  class_name: :Tagging,
  primary_key: :id,
  foreign_key: :tag_id


  has_many :links,
  -> { distinct }, # '->' means Proc.new
  through: :taggings,
  source: :shortened_urls


  def popular_links #test, refactor
    hot_links = {}

    ShortenedUrl.all.each do |link|
      hot_links[link] = link.num_clicks
    end

    top_links = []
    sorted_links = hot_links.sort_by{|k, v| v}.reverse
    5.times{|idx| top_links << sorted_links[idx][0]}
    top_links
  end


end
