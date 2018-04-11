class MostDangerousDayController < ApplicationController
  def index
    byebug
    @start_date = Time.new(params[:start_date]).strftime('%B %-d, %Y')
    @end_date = Time.new(params[:end_date]).strftime('%B %-d, %Y')
  end
end
