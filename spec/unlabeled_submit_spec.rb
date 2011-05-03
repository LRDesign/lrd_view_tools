require 'spec/spec_helper'
require File.join(File.dirname(__FILE__), '..', 'lib','app', 'helpers', 'lrd_form_helper')
ActionView::Helpers::FormHelper.send(:include, LRD::FormHelper)

describe "form_for().unlabeled_submit", :type => :view do
  let :user do
    view.stub!(:user_path => "#")
    mock_model("User", :login => "Username", :bio => "This is my story", :phone => "626-111-2222")
  end


  let :template do
    <<-EOTEMPLATE
      <%= form_for(user) do |f| %>
         <%= f.unlabeled_submit %>
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
           <%= f.unlabeled_submit('Click Me') %>
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