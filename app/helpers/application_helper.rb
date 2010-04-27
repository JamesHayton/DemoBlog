module ApplicationHelper

  def link_to_with_active_class(name, options = {}, html_options = {})
    html_options.merge!({ :class => 'active' }) if current_page?(options)
    link_to(name, options, html_options)
  end

end
