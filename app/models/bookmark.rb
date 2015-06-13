class Bookmark < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :votes

  validates :url, presence: true
  validates :title, presence: true

  def vote_count
    @bookmarks = Bookmark.all
    @bookmarks.each do |bookmark|
      bookmark.count
    end
  end
end
