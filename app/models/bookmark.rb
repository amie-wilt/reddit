class Bookmark < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  has_many :comments

  validates :url, presence: true
  validates :title, presence: true
end
