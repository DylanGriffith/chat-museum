class Message < ActiveRecord::Base
  include PgSearch
  belongs_to :channel
  pg_search_scope :search, :against => :content
end
