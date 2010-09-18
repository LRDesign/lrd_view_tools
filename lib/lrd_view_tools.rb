require File.join(File.dirname(__FILE__), '..', 'app', 'helpers', 'lrd_view_helper')                                

ActionController::Base.helper(LRD::ViewHelper)
