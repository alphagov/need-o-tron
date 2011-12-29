class ReportMailer < ActionMailer::Base
  include ReportMailerHelper
  
  default from: "winston@alphagov.co.uk"

  def daily_analytics(daily, weekly, top_ten_pages)
    @daily = daily
    @weekly = weekly
    @top_ten_pages = top_ten_table(top_ten_pages)

    case Plek.current.environment
    when 'preview'
      email_address = 'govuk-dev@digital.cabinet-office.gov.uk'
    else
      email_address = 'govuk-team@digital.cabinet-office.gov.uk'
    end

    mail(:to => email_address, :subject => analytics_subject(daily, weekly))
  end
end
