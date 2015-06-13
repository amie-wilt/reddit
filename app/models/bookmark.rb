class Bookmark < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :url, presence: true
  validates :title, presence: true
end
