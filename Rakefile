require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/newplugin'

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'newplugin' do
  self.developer 'ZhangJinzhu', 'wosmvp@gmail.com'
  # self.post_install_message = 'PostInstall.txt'
  self.rubyforge_name     = self.name
  self.extra_deps         = [['thor']]
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }
