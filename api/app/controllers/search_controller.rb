class SearchController < ApplicationController

  def index
    if params[:query].include? 'Find a business that caters '
      selector = /(?<=\ caters\s)(\w+)/.match(params[:query])
      identifier = params[:query].slice!(selector[1])
      businesses = Business.where("'#{identifier}' = ANY (services)").order(created_at: :desc)
    elsif params[:query].include? 'Find a business located at '
      selector = /located at (.*)/.match(params[:query])
      identifier = params[:query].slice!(selector[1])
      businesses = Business.where("location like ?", "%#{identifier}%").order(created_at: :desc)
    elsif params[:query].empty?
      businesses = Business.published.order(created_at: :desc)
    end

    render json: businesses, status: 200
  end

end
