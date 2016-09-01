class VotePolicy < ApplicationPolicy

  def upvote?
      user.present? && user.moderator? || user.admin? || user.user?
  end

  def downvote?
    upvote?
  end

end
