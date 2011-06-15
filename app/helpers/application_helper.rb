module ApplicationHelper
  def markdown(markdown_text)
    markdown = RDiscount.new(markdown_text, :smart, :filter_html, :filter_styles, :safelink)
    markdown.to_html.html_safe
  end
  
  def status_name(status = '')
    status ||= ""
    status.gsub('-', '').capitalize
  end
end
