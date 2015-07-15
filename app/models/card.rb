class Card < ActiveRecord::Base

  include FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  enum category: [ :person, :band, :theme, :period, :place, :chapter ]

  belongs_to :user

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
