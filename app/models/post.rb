class Post < ActiveRecord::Base
  searchkick
  acts_as_votable
  belongs_to :user
  has_many :comments
  belongs_to :category

  def upvote_score
    self.get_upvotes.size
  end

  def downvote_score
    self.get_downvotes.size
  end
end
