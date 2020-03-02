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
end
