require 'spec/spec_helper'

describe "form_for().labelled_input", :type => :view do
  it "should render an inline template" do
    render :inline => "<%= who%> rocks!", :locals => {:who => "Judson"}
    rendered.should == "Judson rocks!"
  end

  def user_path
    '#'
  end

  it "should render a labeled_input successfully" do
    user = mock_user
    render(:inline => <<-EOTEMPLATE, :locals => { :user => user })
      <%= form_for(user) do |f| %>
         <%= f.labeled_input(:login) %>
      <%- end -%>
    EOTEMPLATE
    rendered.should_not be_nil
  end


  def mock_user
    mock_model("User",
      :login => 'UserName'
    )
  end
end
