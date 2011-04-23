p "Loading LRD::FormHelper File"

module LRD
  module FormHelper

    p "Defining LRD::FormHelper Module"

    def self.included(arg)
      p "LRD::FormHelper included in  #{arg}"
      ActionView::Helpers::FormBuilder.send(:include, LRD::FormBuilder)
    end

    # Returns a <div> containing a label, an input, and an option comment
    # block, pre-styled in LRD style.
    #
    # pass  :label => false  to suppress the label text.  (A label tag is still emitted.)
    # pass  :required => true  to dispay as a required field
    # pass  :text => "foo"  to override the label text
    # pass  :class => 'foo' to add 'foo' to the CSS class of the <div>
    # pass  :comment => "text"  to append a span.comment with text after the input
    # pass  :input_type => 'password' } to use a password_field instead of a text_field
    #    (also supported: text, passsword, hidden, file, text_area, search, telephone, url
    #     email, range, submit)
    #
    # ==== Examples (in HAML):
    #   - form_for(@user) do
    #     = f.labeled_input(:login)
    #   # => <div class='labeled_input'>
    #   # =>   <label for='user_login'>login</label>
    #   # =>   <input type='text' name='user[login]' id='user_login' value="#{@user.login}" />
    #   # => </div>
    def labeled_input(object_name, method, options = {}, &block)
      divclass = labeled_input_divclass(options)
      comment = comment_for_labeled_input(options.delete(:comment))
      if block_given?
        input = yield
      else
        input = input_for_labeled_input(object_name, method, options)
      end

      if text = options.delete(:text)
        label = label(object_name, method, text, options)
      else
        label = label(object_name, method, options)
      end
      p "divclass is #{divclass}"
      content_tag(:div, (label + input + comment), { :class => divclass })
    end

    def comment_for_labeled_input(text)
      if text
        content_tag( :span, { :class => 'comment' } ) { text }
      else
        ""
      end
    end


    def labeled_input_divclass(options)
      cssclass = "labeled_input"
      cssclass += " required" if options[:required]
      cssclass += " #{options[:class]}" if options[:class]
      cssclass
    end

    def input_for_labeled_input(object_name, method, options)
      case input_type = options.delete(:input_type).to_s
      when "text", ""
        input = text_field(     object_name, method, options)
      when "password"
        input = password_field( object_name, method, options)
      when "hidden"
        input = hidden_field(   object_name, method, options)
      when "file"
        input = file_field(     object_name, method, options)
      when "text_area"
        input = text_area(      object_name, method, options)
      when "search"
        input = search_field(   object_name, method, options)
      when "telephone"
        input = telephone_field(object_name, method, options)
      when "url"
        input = url_field(      object_name, method, options)
      when "email"
        input = email_field(    object_name, method, options)
      when "number"
        input = number_field(   object_name, method, options)
      when "range"
        input = range_field(    object_name, method, options)
      when "submit"
        input = submit(         options[:submit_text], options)
      else
        raise "labeled_input input_type #{input_type} is not a valid type!"
      end
      input
    end

    def unlabeled_input(object_name, method, options)
      labeled_input(object_name, method, options.merge!(:label => false))
    end

    # creates a submit button that lines up with a bunch of labeled_input fields
    def unlabeled_submit(text = nil)
      labeled_input(nil, :input_type => :submit, :submit_text => text)
    end
  end
end

  # # pass { :nolabel => true } to replace the label with a spacer
  #   # pass { :required => true } to dispay as a required field
  #   # pass { :text => "foo" } to override the label text
  #   # pass { :class => 'foo'} to add 'foo' to the CSS class of the <div>
  #   #
  #   # input_options hash gets passed directly to the input field
  #   def labeled_input(form, field, options = {}, input_options = {})
  #     options[:text] = "&nbsp;".html_safe if options[:nolabel]
  #     options.reverse_merge!(:text => nil,:required => false, :nolabel => false)
  #     options.merge!(:form => form, :field => field)
  #     input_options.reverse_merge!( :size => 30 )
  #
  #     cssclass = "labeled_input"
  #     cssclass += " required" if options[:required]
  #     cssclass += " #{options[:class]}" if options[:class]
  #
  #     unless input = options[:input]
  #       input = form.text_field field, input_options
  #     end
  #
  #     if field.blank?
  #       label = (content_tag :label, options[:text]).html_safe
  #     else
  #       label = (form.label field, options[:text]).html_safe
  #     end
  #     comment = options[:comment] ? content_tag( :span, { :class => 'comment' } ) { options[:comment] }  : ""
  #
  #     content_tag(:div, (label + input + comment), { :class => cssclass }).html_safe
  #   end
# f.labeled_input(stuff, :input_type => :hidden)
#
# f.labeled_input(stuff){ f.hidden_field(stuff) }
#

module LRD::FormBuilder
  def labeled_input(method, options = {})
    @template.labeled_input(@object_name, method, objectify_options(options))
  end
end


