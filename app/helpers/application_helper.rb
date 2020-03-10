require 'json'
require 'open-uri'
module ApplicationHelper

  def plural(exp, time)
    if time == 1
      exp
    else
      exp + 's'
    end
  end

  def duration(time)
    a, b = time.divmod(60)
    if b == 0
      "#{a} #{plural('hour', a)}"
    elsif a == 0
      "#{b} #{plural('min', b)}"
    else
      "#{a} #{plural('hour', a)} and #{b} #{plural('min', b)}"
    end
  end

  def stars(rating)
    if (rating <= 5)
      '★' * rating + '☆' * (5 - rating)
    else
      'Bullshirt'
    end
  end

  def rating(reviews)
    sum = reviews.map { |review| review.rating }.reduce(0, :+)
    if reviews.count != 0
      stars(sum / reviews.count) + ' (' + reviews.count.to_s + plural(' review', reviews.count) + ')'
    else
      'No reviews'
    end
  end

  def total_rating(reviews)
    sum = reviews.map { |review| review.rating }.reduce(0, :+)
    if reviews.count != 0
      (sum.fdiv(reviews.count).round(2)).to_s + ' ' + stars(sum / reviews.count)
    else
      'No reviews'
    end
  end

  def googlemap(itinerary)
    url_root = "https://www.google.com/maps/dir/?api=1&origin="
    origin_coordinates = ERB::Util.url_encode("#{itinerary.locations.first.latitude},#{itinerary.locations.first.longitude}")
    destination_prefix = "&destination="
    destination_coordinates = ERB::Util.url_encode("#{itinerary.locations.last.latitude},#{itinerary.locations.last.longitude}")
    travel_mode = "&travelmode=walking&waypoints="
    x = []

    itinerary.locations.map do |location|

      long= location.longitude
      lat = location.latitude
      d_local = ERB::Util.url_encode("#{lat},#{long}|")
      x << d_local
    end
    x.shift()
    x.pop()
    waypoints = x.join
    google_map = "#{url_root}#{origin_coordinates}#{destination_prefix}#{destination_coordinates}#{travel_mode}#{waypoints}"
    return google_map
  end

  def photo(itinerary)
    if itinerary.photo.attached?
      cl_image_tag itinerary.photo.key, height: 200, width: 300, crop: :fill
    else
      image_tag "bridge.jpg", alt: "alttext"
    end
  end

  def routing(itinerary)

  url_root = 'https://api.mapbox.com/directions/v5/mapbox/'
  travel_mode = 'walking/'
  origin_coordinates = "#{itinerary.locations.first.longitude},#{itinerary.locations.first.latitude};"
  destination_coordinates = "#{itinerary.locations.last.longitude},#{itinerary.locations.last.latitude}"
  mapbox = '?geometries=geojson&access_token=pk.eyJ1Ijoic3RldmVzcGlkZXJzIiwiYSI6ImNrN2JqZW43MjAyM3YzcWxjb2VkZG9qNmUifQ.iMQH53oEUdtY8nAbUaAl3w'
  url = "#{url_root}#{travel_mode}#{origin_coordinates}#{destination_coordinates}#{mapbox}"

  routes_serialized = open(url).read
  routes = JSON.parse(routes_serialized)
  # return routes['routes'][0]["legs"][0]["summary"]
  end

end
  # def photo_attached(locations)
  #   x = []
  #   @locations.each do |location|
  #     x << location.photos.attached?
  #     byebug
  #   end
  #   photo_tf = x?
  #   return photo_tf
  # end

  # end

