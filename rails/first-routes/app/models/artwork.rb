class Artwork < ApplicationRecord
  validates :artist_id, uniqueness: { scope: :title }
  belongs_to :artist, class_name: 'User', foreign_key: 'artist_id'
end
