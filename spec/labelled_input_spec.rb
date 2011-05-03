require 'spec/spec_helper'
require File.join(File.dirname(__FILE__), '..', 'lib','app', 'helpers', 'lrd_form_helper')
ActionView::Helpers::FormHelper.send(:include, LRD::FormHelper)

describe "form_for().labelled_input", :type => :view do
  it "should render an inline template" do
    render :inline => "<%= who%> rocks!", :locals => {:who => "Judson"}
    rendered.should == "Judson rocks!"
  end

  let :user do
    view.stub!(:user_path => "#")
    mock_model("User", :login => "Username", :bio => "This is my story", :phone => "626-111-2222")
  end


  describe "with default type" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:login) %>
        <%- end -%>
      EOTEMPLATE
    end

    it "should render successfully" do
      render(:inline => template, :locals => { :user => user })
      rendered.should_not be_nil
    end

    it "should have a label" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath('//label')
    end

    it "should have a text input" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath('//input')
    end

    it "should have a div with class labeled_input" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath('//div[@class="labeled_input"]')
    end
  end

  describe "with block passed" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:login) do %>
             <select name='foo'>
                <option value='bar'>Bar</option>
                <option value='baz'>Baz</option>
                <option value='bletch'>Bletch</option>
             </select>
          <%- end -%>
        <%- end -%>
      EOTEMPLATE
    end

    it "should not generate the default input" do
      render(:inline => template, :locals => { :user => user })
      rendered.should_not have_xpath("//div[@class='labeled_input']/input")
    end

    it "should insert the block's elements" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath(
        "//div[@class='labeled_input']/select[@name='foo'][count(option)=3]"
      )
    end
  end

  describe "with :required => true" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:login, :required => true) %>
        <%- end -%>
      EOTEMPLATE
    end

    it "should set the div class to required" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath("//div[contains(@class,'required')][contains(@class, 'labeled_input')]")
    end

    it "should set the input class to required" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath("//div[contains(@class,'required')]/input[contains(@class, 'required')]")
    end

  end


  describe "with label text specified" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:login, :text => 'Label text') %>
        <%- end -%>
      EOTEMPLATE
    end

    it "should set the content of the label" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath("//label[.='Label text']")
    end

    it "should not apply a 'text' attribute to the other elements" do
      render(:inline => template, :locals => { :user => user })
      rendered.should_not have_xpath("//label[@text]")
      rendered.should_not have_xpath("//input[@text]")
      rendered.should_not have_xpath("//div[@text]")
    end

    it "should not apply a class 'text' to the other elements" do
      render(:inline => template, :locals => { :user => user })
      rendered.should_not have_xpath("//label[contains(@class, 'text')]")
      rendered.should_not have_xpath("//input[contains(@class, 'text')]")
      rendered.should_not have_xpath("//div[contains(@class, 'text')]")
    end
  end

  describe "with a comment specified" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:login, :comment => 'Reminder text') %>
        <%- end -%>
      EOTEMPLATE
    end

    it "should add a span for the comment" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath("//div/span[contains(@class, 'comment')][.='Reminder text']")
    end

    it "should not apply a comment attribute to the other elements" do
      render(:inline => template, :locals => { :user => user })
      rendered.should_not have_xpath("//label[@comment]")
      rendered.should_not have_xpath("//input[@comment]")
      rendered.should_not have_xpath("//div[@comment]")
    end

    it "should not apply a class 'comment' to the other elements" do
      render(:inline => template, :locals => { :user => user })
      rendered.should_not have_xpath("//label[contains(@class, 'comment')]")
      rendered.should_not have_xpath("//input[contains(@class, 'comment')]")
      rendered.should_not have_xpath("//div[contains(@class, 'comment')]")
    end
  end

  describe "with a divclass specified" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:login, :divclass => 'foobar') %>
        <%- end -%>
      EOTEMPLATE
    end

    it "should apply the appropriate class to the div" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath("//div[contains(@class, 'foobar')]")
    end

    it "should not apply the divclass to the input or label" do
      render(:inline => template, :locals => { :user => user })
      rendered.should_not have_xpath("//label[contains(@class, 'foobar')]")
      rendered.should_not have_xpath("//input[contains(@class, 'foobar')]")
    end
  end

  describe "with type :submit" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:bio, :type => :submit) %>
        <%- end -%>
      EOTEMPLATE
    end

    it "should have a submit button" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath("//div[@class='labeled_input']/input[@type='submit']")
    end

    describe "and submit text" do
      let :template do
        <<-EOTEMPLATE
          <%= form_for(user) do |f| %>
             <%= f.labeled_input(:bio, :type => :submit, :submit_text => 'Click Me') %>
          <%- end -%>
        EOTEMPLATE
      end

      it "should have a submit button with text" do
        render(:inline => template, :locals => { :user => user })
        rendered.should have_xpath("//div[@class='labeled_input']/input[@type='submit'][@value='Click Me']")
      end

      it "should not put a 'submit_text' attribute in the other tags" do
        render(:inline => template, :locals => { :user => user })
        rendered.should_not have_xpath("//*[@submit_text]")
      end
    end
  end


  describe "with type :text_area" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:bio, :type => 'text_area') %>
        <%- end -%>
      EOTEMPLATE
    end

    it "should have a text area" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath('//textarea')
    end
  end


  describe "with type :textarea" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:bio, :type => :textarea) %>
        <%- end -%>
      EOTEMPLATE
    end

    it "should have a text area" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath('//textarea')
    end
  end

  describe "with type :telephane" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:phone, :type => :telephone) %>
        <%- end -%>
      EOTEMPLATE
    end
    it "should have a telephone input" do
      render(:inline => template, :locals => { :user=> user })
      rendered.should have_xpath('//input[@type="tel"]')
    end

  end


end
