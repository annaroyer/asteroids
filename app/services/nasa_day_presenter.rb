class NasaDayPresenter
  attr_reader :start_date, :end_date

  def initialize(dates)
    @start_date = dates[:start_date].to_time.strftime('%B%e, %Y')
    @end_date = dates[:end_date].to_time.strftime('%B%e, %Y')
    dates = dates.transform_values do |date|
      date.to_time.to_s.split(' ').first
    end
    @days = NasaDay.all_in_range(dates)
  end

  def most_dangerous
    days.max do |a, b|
      a.near_earth_objects.count <=> b.near_earth_objects.count
    end
  end

  private
    attr_reader :days
end
