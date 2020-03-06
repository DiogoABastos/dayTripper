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
end
