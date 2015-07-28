module ApplicationHelper

  def flash_message
    if flash[:error]
      content_tag(:div, class: "alert alert-error") do
        flash[:error]
      end
    elsif flash[:success]
      content_tag(:div, class: "alert alert-success") do
        flash[:success]
      end
    end
  end

  def modal_flash_message(modal)
    flash_type = "modal_#{modal}_error".to_sym

    if flash[flash_type]
      content_tag(:div, class: "alert alert-error") do
        flash[flash_type]
      end
    end
  end

  def markdown(text)
    return if text.blank?

    #text.gsub(/\[\[([^\]]+)\]\]/) { '<a href='+$1+'>'+$1+'</a>' }

    options = {
      #filter_html:     true,
      hard_wrap:       true, 
      #link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe

  end

  def wikilinks(text)
    
  end


end
