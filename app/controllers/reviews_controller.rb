class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @flat = Flat.find(params[:flat_id])
    sanitize_params
    @review = @flat.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      flash[:notice] = "You're review has been saved."
    else
      if @review.errors.messages[:user]
        flash[:alert] = "You can't review your own flat."
      else
        flash[:alert] = "An error occured saving your review."
      end
    end

    redirect_to flat_path(@flat)
  end

private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def sanitize_params
    params[:review][:rating] = params[:review][:rating].to_i
  end
end
