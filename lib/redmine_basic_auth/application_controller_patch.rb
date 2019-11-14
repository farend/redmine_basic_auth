require_dependency 'application_controller'

module RedmineBasicAuth

  REALM = 'redmine_basic_auth'

  module ApplicationControllerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval  do
        before_action :require_basic_auth
      end
    end
  end

  module InstanceMethods
    def require_basic_auth
      return true if Setting.plugin_redmine_basic_auth['enabled'].to_i == 0
      authenticate_or_request_with_http_basic(REALM) do |user_name, password|
        ActiveSupport::SecurityUtils.secure_compare(user_name, Setting.plugin_redmine_basic_auth['user_name']) &
        ActiveSupport::SecurityUtils.secure_compare(password, Setting.plugin_redmine_basic_auth['password'])
      end
    end
  end
end

ApplicationController.send(:include, RedmineBasicAuth::ApplicationControllerPatch)
