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

  it "should render a labeled_input successfully" do
    render(:inline => <<-EOTEMPLATE, :locals => { :user => user })
      <%= form_for(user) do |f| %>
         <%= f.labeled_input(:login) %>
      <%- end -%>
    EOTEMPLATE
    p "Rendered is: ", rendered
    rendered.should_not be_nil

  end
end
