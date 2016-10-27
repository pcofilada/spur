class BusinessesController < ApplicationController

  def index
    businesses = Business.published.order(created_at: :desc)

    render json: businesses, status: 200
  end

  def submit
    business = Business.new(business_params)
    business.services = params[:business][:services].split(',')

    if business.save
      render json: business, status: 201
    else
      render json: { error: "Can't submit business!" }, status: 422
    end
  end

private

  def business_params
    params.require(:business).permit(:name, :image, :description, :website, :facebook_page, :contact_number, :location, :services)
  end

end
