class MostDangerousDayController < ApplicationController
  def index
    @start_date = Time.parse(params[:start_date]).strftime('%B %e, %Y')
    @end_date = Time.parse(params[:end_date]).strftime('%B %e, %Y')
    @most_dangerous_day = NasaService.most_dangerous_day(params[:start_date], params[:end_date])
  end
end
