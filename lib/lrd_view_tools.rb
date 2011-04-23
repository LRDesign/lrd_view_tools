require File.join(File.dirname(__FILE__), 'app', 'helpers', 'lrd_view_helper')
require File.join(File.dirname(__FILE__), 'app', 'helpers', 'lrd_debug_helper')
require File.join(File.dirname(__FILE__), 'app', 'helpers', 'lrd_form_helper')

module LRD::DevTools
  class Railtie < Rails::Railtie
    ActionController::Base.helper(LRD::ViewHelper)
    ActionController::Base.helper(LRD::DebugHelper)
    ActionView::Helpers::FormHelper.send(:include, LRD::FormHelper)
  end
end
