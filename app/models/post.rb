class Post < ActiveRecord::Base
  searchkick
  belongs_to :user
  has_many :comments
end
