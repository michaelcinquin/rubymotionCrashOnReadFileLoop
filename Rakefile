# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'readFile'
  app.files << Dir.glob("./config/*.rb")

    app.info_plist['CFBundleDocumentTypes'] = [
    {
      'CFBundleTypeExtensions' => ['img','iso','dmg'],
      'CFBundleTypeRole' => 'Viewer'
    }
  ]

    
  app.deployment_target = '10.9'
  ENV['appname']=app.name #does not work !

end
