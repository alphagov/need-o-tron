require 'oauth'
require 'garb'
require 'active_support/core_ext'

class MainVisits
  extend Garb::Model

  metrics :pageviews, :unique_pageviews, :avg_time_on_page
  dimensions :page_path, :page_title
end

class Overview
  extend Garb::Model

  metrics :visitors, :new_visits
end

module AnalyticsUtils
  def percentage_change(from, to)
    change = 100 * (to.to_f - from.to_f) / from.to_f
    change = change.round(2)
    if change > 0
      "+#{change}"
    else
      change.to_s
    end
  end
end

class AnalyticsInterface

  attr_accessor :profile
  
  def initialize(analytics_id)
    establish_garb_session
    self.profile = Garb::Management::Profile.all.detect { |p| p.web_property_id == analytics_id }
  end
  
  def weekly_stats
    first_period = overview(7.days.ago, Date.today)
    second_period = overview(14.days.ago, 7.days.ago)
    describe_period(first_period, second_period, "this week", "last week")
  end

  def daily_stats
    first_period = overview(1.days.ago, Date.today)
    second_period = overview(2.days.ago, 1.days.ago)
    describe_period(first_period, second_period, "yesterday", "the day before")
  end

  def main_visits_data
    profile.main_visits(
      :filters => { :page_path.does_not_contain => 'admin' },
      :start_date => 2.days.ago,
      :end_date => 1.day.ago,
      :limit => 10,
      :sort => :unique_pageviews.desc
    )
  end

private
  include AnalyticsUtils

  def overview(start_date, end_date)
    profile.overview(
      :filters => { :page_path.does_not_contain => 'admin' }, 
      :start_date => start_date,
      :end_date => end_date
    ).first
  end

  def describe_period(current_period, previous_period, this_kind, last_kind)
    {
      visitors: current_period.visitors,
      visitors_change: percentage_change(previous_period.visitors, current_period.visitors),
      new_visits: current_period.new_visits,
      new_visits_change: percentage_change(previous_period.new_visits, current_period.new_visits)
    }
  end

  def build_oauth_token
    consumer = OAuth::Consumer.new('anonymous', 'anonymous', {
      :site => 'https://www.google.com',
      :request_token_path => '/accounts/OAuthGetRequestToken',
      :access_token_path => '/accounts/OAuthGetAccessToken',
      :authorize_path => '/accounts/OAuthAuthorizeToken'
    })
    token = '1/3kKwcr3qSDFFnDkNurMa0wS6RJpxZB-zHJzEDiiWu-o'
    secret = 'aJMITPFTF8UyyDnzCOoJJFCH'
    OAuth::AccessToken.new(consumer, token, secret)
  end
  
  def establish_garb_session
    Garb::Session.access_token = build_oauth_token
  end
end
