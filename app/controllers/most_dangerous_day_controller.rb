class MostDangerousDayController < ApplicationController
  def index
    @start_date = Time.new(params[:start_date]).strftime('%B %e, %Y')
    @end_date = Time.new(params[:end_date]).strftime("%B #{params[:end_date].split('-').last.to_i}, %Y")
  end
end
