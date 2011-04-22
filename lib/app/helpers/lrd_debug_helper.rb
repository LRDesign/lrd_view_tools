module LRD
  module DebugHelper
    require 'pp'
    require 'stringio'

    def lrd_debug(object)
     "<pre>#{h(pp_s(object))}</pre>"
    end

    def pp_s(*objs)
        s = StringIO.new
        objs.each {|obj|
          PP.pp(obj, s)
        }
        s.rewind
        s.read
    end
    alias :pp_to_s :pp_s

    def debug_link(name)
      link_to name.titleize, '#', :onclick => "Element.toggle('#{name}_debug_info'); return false;"
    end
    def debug_block(name, &block)
      content = capture(&block)
      title = content_tag(:h2, name.titleize)
      concat(content_tag :fieldset, content, {:id => "#{name}_debug_info", :style => 'display: none;' } )
    end

  end
end