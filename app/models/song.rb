class Song < ApplicationRecord
    validates :title, presence: true
    validate :ensure_unique
    validates :released, inclusion: { in: [true, false] }
    with_options if: :released do |s|
        s.validates :release_year, presence: true
        s.validates :release_year, numericality: { less_than_or_equal_to: DateTime.now.year }
    end
    validates :artist_name, presence: true

    def ensure_unique
        if Song.all.where(title: self.title, artist_name: self.artist_name, release_year: self.release_year).any?
            errors[:title] << "Artist cannot have two songs of the same name."
        end
    end
end
