module ApplicationHelper
  def markdown(markdown_text)
    markdown = RDiscount.new(markdown_text, :smart, :filter_html, :filter_styles, :safelink)
    markdown.to_html.html_safe
  end
end
