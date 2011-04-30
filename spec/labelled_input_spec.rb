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
    mock_model("User", :login => "Username")
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
  end

  describe "with type text_area" do
    let :template do
      <<-EOTEMPLATE
        <%= form_for(user) do |f| %>
           <%= f.labeled_input(:login, :input_type => 'text_area') %>
        <%- end -%>
      EOTEMPLATE
    end

    it "should have a text area" do
      render(:inline => template, :locals => { :user => user })
      rendered.should have_xpath('//textarea')
    end
  end



end
