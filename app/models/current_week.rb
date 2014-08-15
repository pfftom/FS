class CurrentWeek
  def self.week
    Week.first.value
  end

  def self.increment_week
    Week.first.increment!(:value)
  end
end
