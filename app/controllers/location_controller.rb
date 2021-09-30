require 'json'
require 'open-uri'
require 'uri'

class LocationController < ApplicationController

  def search
    @gps = find_location(params[:lat],params[:lng])
    p @gps
    render json: @gps
  end

  private

  def request_api(url)
    response = URI.open(url)
    response_read = response.read() 

    return nil if response.status[0] != "200"

    @json = JSON.parse(response_read)
    @gps = {}
    @json["features"].each do |item|
      @gps[item["id"]] = [item["place_name"]]
      p @gps
    end
    return @gps 

  end

  def find_location(lat,lng)
    return request_api(
      "https://api.mapbox.com/geocoding/v5/mapbox.places/#{lng},#{lat}.json?access_token=#{ENV["MAPBOX_API_KEY"]}"
    )
  end
end
