module LRD
  module ViewTools

    class Railtie < Rails::Railtie

      require File.expand_path('../app/helpers/lrd_view_helper', __FILE__)
      require File.expand_path('../app/helpers/lrd_form_helper', __FILE__)
      require File.expand_path('../app/helpers/lrd_debug_helper', __FILE__)

      ActionController::Base.helper(LRD::ViewHelper)
      ActionController::Base.helper(LRD::DebugHelper)
      ActionView::Helpers::FormHelper.send(:include, LRD::FormHelper)

    end
  end
end