class NasaDayPresenter
  attr_reader :start_date, :end_date

  def initialize(dates)
    @start_date = Time.parse(dates[:start_date]).strftime('%B %e, %Y')
    @end_date = Time.parse(dates[:end_date]).strftime('%B %e, %Y')
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
