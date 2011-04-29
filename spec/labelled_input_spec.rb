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

  let :template do
    <<-EOTEMPLATE
      <%= form_for(user) do |f| %>
         <%= f.labeled_input(:login) %>
      <%- end -%>
    EOTEMPLATE
  end

  describe "with default type" do
    it "should render successfully" do
      render(:inline => template, :locals => { :user => user })
      rendered.should_not be_nil
    end

    it "should have a label" do
      render(:inline => template, :locals => { :user => user })
      # p "Rendered is: ", rendered
      rendered.should have_css('label')
      # rendered.should =~ /<label/
    end

    it "should have a text input" do
      render(:inline => template, :locals => { :user => user })
      rendered.should =~ /<input/
    end
  end

end
