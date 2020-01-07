class NestController < ApplicationController
  def about
    @jobs = Job.all
  end

  def csp_reports
  end

  def portfolio
  end
end
