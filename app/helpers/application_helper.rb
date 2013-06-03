module ApplicationHelper
  def subtitle_content
    content_for(:subtitle_text) || "Image Gallery"
    "immage gallery"
  end
end
