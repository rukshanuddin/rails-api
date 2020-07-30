class Link < ApplicationRecord
    belongs_to :topic, foreign_key: "topic_id"
    has_many :comments
    has_many :votes

    # scope :hottest, -> { order(points: :desc) }
    # scope :newest, -> { order(created_at: :desc) }

    validates :link,
              presence: true,
              uniqueness: { case_sensitive: false }

    def comment_count
      comments.length
    end

    def upvotes
    #   votes.sum(:upvote)
    end

    def downvotes
    #   votes.sum(:downvote)
    end

    # def points 
        # points = upvotes - downvotes
    #     update_attributes(points: points)
    # end
end