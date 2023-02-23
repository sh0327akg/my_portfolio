module ApplicationHelper
  def page_title(page_title = '')
    base_title = "草刈山雄"
    page_title.empty? ? base_title : "#{base_title}"|"#{page_title}"
  end
end
