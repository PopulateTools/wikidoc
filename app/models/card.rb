class Card < ActiveRecord::Base

  include FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  enum category: [ :person, :band, :theme, :period, :place, :chapter, :label ]

  belongs_to :user

  acts_as_followable
  acts_as_follower

  after_create :follow_cards
  after_save :follow_cards

  def content_wikilinked
    # chapucilla; habría que meterlo como una opción/extensión de markdown para que se compatibilice con la opción filter_html
    text = content.gsub(/\[\[([^\]]+)\]\]/) { add_wiki_links($1) }
  end
  
  def card_exists(name)
    Card.friendly.exists?(normalize_friendly_id(name))
  end 

  def add_wiki_links(name)
    if card_exists(name)
      '<a href="'+normalize_friendly_id(name)+'">'+name+'</a>'
    else
      '<a href="'+name+'" class="dont_exist">'+name+'</a> (no existe)'
    end
  end
    
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def self.normalize_friendly_id(string)
    normalize_friendly_id(string)
  end 
  
  def normalize_friendly_id(string)
    # super.upcase.gsub("-", "_")

    # code from https://github.com/rails/rails/blob/5ea3f284a4d07f5572f7ae2a7442cca8761fa8fc/activesupport/lib/active_support/inflector/transliterate.rb#L81
    # replace accented chars with their ascii equivalents
    parameterized_string = ActiveSupport::Inflector.transliterate(string)
    sep = '_'
    # Turn unwanted chars into the separator
    parameterized_string.gsub!(/[^a-z0-9\-_]+/i, sep)
    unless sep.nil? || sep.empty?
      re_sep = Regexp.escape(sep)
      # No more than one of the separator in a row.
      parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
      # Remove leading/trailing separator.
      parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/i, '')
    end
    parameterized_string

  end

  def follow_cards
    # book = Book.find(1)
    # user = User.find(1)
    # user.follow(book) # Creates a record for the user as the follower and the book as the followable

    # buscar a las páginas a las que se enlaza
    self.content.gsub(/\[\[([^\]]+)\]\]/) { follow_linked_card($1) }
    
  end

  def follow_linked_card(name)
    logger.debug name
    if card_exists(name)
      c = Card.friendly.find(normalize_friendly_id(name))
      # self.follow(c)
      c.follow(self)
    end
  end

end
