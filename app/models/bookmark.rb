class Bookmark < ActiveRecord::Base
  has_many :comments

  validates :url, presence: true
  validates :title, presence: true
end
