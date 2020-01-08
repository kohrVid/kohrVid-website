class NestController < ApplicationController
  def about
    @jobs = Job.order(start_date: :desc)
  end

  def csp_reports
  end

  def portfolio
  end
end
