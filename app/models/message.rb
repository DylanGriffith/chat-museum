class Message < ActiveRecord::Base
  include PgSearch
  belongs_to :server
  pg_search_scope :search,
    :against => [:content],
    :using => {
      :tsearch => {:dictionary => "english"}
    }
end
