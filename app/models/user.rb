class User < ApplicationRecord
  has_secure_password
    has_many :links
    has_many :comments
    has_many :votes
    validates_presence_of :email
    validates_uniqueness_of :email
    validates :password, length: { minimum: 8 }

  # Simple wrapper for Knock, making it easy to grab new tokens
  def to_jwt
    Knock::AuthToken.new(payload: { sub: id }).token
  end
  def owns_link?(link)
      self == link.user
    end

    def owns_comment?(comment)
      self == comment.user
    end

    def upvote(link)
      votes.create(upvote: 1, link: link)
    end

    def upvoted?(link)
      votes.exists?(upvote: 1, link: link)
    end

    def downvote(link)
      votes.create(downvote: 1, link: link)
    end

    def downvoted?(link)
      votes.exists?(downvote: 1, link: link)
    end

    def remove_vote(link)
      votes.find_by(link: link).destroy
    end

end
