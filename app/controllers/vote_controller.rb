class VotesController < ApplicationController
  before_action :authenticate!
  before_action :find_or_create_vote

  def upvote
    update_vote(1)
    flash.now[:success] = "You upvoted!"
  end

  def downvote
    update_vote(-1)
    flash.now[:danger] = "You down voted!"
  end

  private

  def find_or_create_vote
    @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])
    authorize @vote
  end

  def update_vote(value)
    if @vote
      @vote.update(value: value)
      VoteBroadcastJob.perform_later(@vote.comment)
    end
  end
end
