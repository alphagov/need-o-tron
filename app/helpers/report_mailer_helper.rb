module ReportMailerHelper
  require 'terminal-table'
  def top_ten_table(top_ten_pages)
    Terminal::Table.new do |t|
      t.add_row ['Title', 'Page Views', 'Unique Page Views', 'Avg Time on Page']
      t.add_separator
      top_ten_pages.each do |detail|
        t.add_row [detail.page_title, detail.pageviews, detail.unique_pageviews, detail.avg_time_on_page.to_i]
      end
    end
  end
  
  def analytics_subject(daily, weekly)
    [
      "NEEDOTRON DAILY: Yesterday: #{daily[:visitors]} (#{daily[:visitors_change]}%) #{daily[:new_visits]} (#{daily[:new_visits_change]}%)",
      "7 days: #{weekly[:visitors]} (#{weekly[:visitors_change]}%) #{weekly[:new_visits]} (#{weekly[:new_visits_change]}%)"
    ].join(' | ')
  end
end