class FeedbackEntriesController < ApplicationController
  def create
    @feedback_entry = FeedbackEntry.create!(feedback_entry_params)
    render json: @feedback_entry, status: :created
  end

  private

  def feedback_entry_params
    params.require(:feedback_entry).permit(:text, :confirmation_token)
  end
end
