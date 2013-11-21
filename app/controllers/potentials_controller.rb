class PotentialsController < ApplicationController
  def create
    @potential = Potential.create!(potential_params)
    PotentialMailer.welcome(@potential).deliver
    render json: @potential, status: :created
  end

  def update
    @potential = Potential.find_by(confirmation_token: params[:confirmation_token])
    @potential.confirmed = true
    @potential.save!
    redirect_to "/#/info/feedback?confirmed&confirmation_token=#{params[:confirmation_token]}"
  rescue Mongoid::Errors::Validations, Mongoid::Errors::DocumentNotFound
    redirect_to '/#/info/error?code=wrong_confirmation_token'
  end

  def destroy
    Potential.find_by(unsubscribe_token: params[:unsubscribe_token]).destroy
    redirect_to '/#/info/feedback?unsubscribed'
  rescue Mongoid::Errors::DocumentNotFound
    redirect_to '/#/info/error?code=noone_to_unsubscribe'
  end

  private

  def potential_params
    params.require(:potential).permit(:email)
  end
end
