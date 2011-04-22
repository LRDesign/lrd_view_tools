module LRD
  module FormHelper
    # pass { :nolabel => true } to replace the label with a spacer
    # pass { :required => true } to dispay as a required field
    # pass { :text => "foo" } to override the label text
    # pass { :class => 'foo'} to add 'foo' to the CSS class of the <div>
    #
    # input_options hash gets passed directly to the input field
    def labeled_input(form, field, options = {}, input_options = {})
      options[:text] = "&nbsp;".html_safe if options[:nolabel]
      options.reverse_merge!(:text => nil,:required => false, :nolabel => false)
      options.merge!(:form => form, :field => field)
      input_options.reverse_merge!( :size => 30 )

      cssclass = "labeled_input"
      cssclass += " required" if options[:required]
      cssclass += " #{options[:class]}" if options[:class]

      unless input = options[:input]
        input = form.text_field field, input_options
      end

      if field.blank?
        label = (content_tag :label, options[:text]).html_safe
      else
        label = (form.label field, options[:text]).html_safe
      end
      comment = options[:comment] ? content_tag( :span, { :class => 'comment' } ) { options[:comment] }  : ""

      content_tag(:div, (label + input + comment), { :class => cssclass }).html_safe
    end

    # creates a submit button that lines up with a bunch of labeled_input fields
    def unlabeled_submit(form, text = nil)
      if text
        labeled_input(form, nil, :input => form.submit(text), :nolabel => true).html_safe
      else
        labeled_input(form, nil, :input => form.submit, :nolabel => true).html_safe
      end
    end
  end
end