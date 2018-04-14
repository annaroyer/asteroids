class MostDangerousDayController < ApplicationController
  def index
    @nasa_days = NasaDayPresenter.new(dates)
  end

  private
    def dates
      params.permit(:start_date, :end_date)
    end
end
