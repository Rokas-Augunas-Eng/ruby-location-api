require 'json'
# require 'open-uri'

class LocationController < ApplicationController
  # before_action :set_default_response_format

  def search
    @gps = find_location(params[:lat],params[:lng])

    render json: @gps
    # render json: { message: "Successfully updated" }
  end

  # private

  def request_api(url)
    response = URI.open(url)
    p response

    return nil if response.status != 200

    # @json = JSON.parse(response.body)
    @json = JSON.parse(response.body)

  end

  def find_location(lat,lng)
    return request_api(
      "https://api.mapbox.com/geocoding/v5/mapbox.places/#{lng},#{lat}.json?access_token=#{ENV["MAPBOX_API_KEY"]}"
    )
  end

  # def set_default_response_format
  #   request.format = :json
  # end
end
