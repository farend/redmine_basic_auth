Redmine::Plugin.register :redmine_basic_auth do
  name 'Redmine Basic Auth plugin'
  author 'Far End Technologies Corporation'
  description ''
  version '0.0.1'
  url ''
  author_url 'http://www.farend.co.jp/'

  settings(
    :default => {'enabled' => 0, 'user_name' => 'somebody', 'password' => 'himitsu'},
    :partial => 'redmine_basic_auth/settings'
  )
end

Rails.configuration.to_prepare do
  require 'redmine_basic_auth/application_controller_patch'
end