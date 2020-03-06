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
end
