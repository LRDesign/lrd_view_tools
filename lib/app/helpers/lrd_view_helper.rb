module LRD
  module ViewHelper

    # Stores a headline for later rendering by the layout
    def set_headline(headline)
      content_for(:headline, headline)
    end

    # displays a checkmark if the field is set true
    def bool_checked(field)
      filename = field ? "check.png" : "blank.gif"
      image_tag(filename, :alt => "yes", :size => "16x16")
    end


    # Passes the supplied block to the named partial
    def block_to_partial(partial_name, options = {}, &block)
      # replace :id with :cssid and :class with :cssclass
      if options[:id]
        options[:cssid] = options.delete(:id)
      else
        options[:cssid] = "" if options[:cssid].nil?
      end
      if options[:class]
        options[:cssclass] = options.delete(:class)
      else
        options[:cssclass] = "" if options[:cssclass].nil?
      end

      options.merge!(:body => capture(&block))
      render(:partial => partial_name, :locals => options)
    end

    # a standardized view helper that renders a box with an optional
    # title.   The standard partial for it is in views/shared/_page_block.html.haml
    def page_block(title = nil, options = {}, &block)
      block_to_partial('shared/block', options.merge(:title => title), &block).html_safe
    end

  end

  def debug_link(name)
    link_to name.titleize, '#', :onclick => "Element.toggle('#{name}_debug_info'); return false;"
  end
  def debug_block(name, &block)
    content = capture(&block)
    title = content_tag(:h2, name.titleize)
    concat(content_tag :fieldset, content, {:id => "#{name}_debug_info", :style => 'display: none;' } )
  end

end

