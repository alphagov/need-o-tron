class ReportMailer < ActionMailer::Base
  include ReportMailerHelper
  
  default from: "winston@alphagov.co.uk"

  def daily_analytics(daily, weekly, top_ten_pages)
    @daily = daily
    @weekly = weekly
    @top_ten_pages = top_ten_pages

    case Plek.current.environment
    when 'preview'
      email_address = 'needotron-daily+preview@digital.cabinet-office.gov.uk'
    else
      email_address = 'needotron-daily+production@digital.cabinet-office.gov.uk'
    end

    mail(:to => email_address, :subject => analytics_subject(daily, weekly))
  end
end
