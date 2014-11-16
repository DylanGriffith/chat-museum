class Message < ActiveRecord::Base
  include PgSearch
  belongs_to :channel
  pg_search_scope :trigram_search,
    :against => [:content],
    :using => {
      :tsearch => {:dictionary => "english"}
    }
end
