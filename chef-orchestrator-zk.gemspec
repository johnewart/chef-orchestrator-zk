$:.unshift(File.dirname(__FILE__) + '/lib')
require 'chef_orchestrator_zk/version'

Gem::Specification.new do |s|
  s.name = 'chef-orchestrator-zk'
  s.version = ChefOrchestratorZookeeper::VERSION
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = ['README.md', 'LICENSE' ]
  s.summary = 'Uses ZooKeeper to provide orchestration locks'
  s.description = s.summary
  s.author = 'John Ewart'
  s.email = 'john@johnewart.net'
  s.homepage = 'https://github.com/johnewart/chef-orchestrator-zk'

  s.add_dependency 'chef'
  s.add_dependency 'cheffish'
  s.add_dependency 'zk'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'

  s.bindir       = "bin"
  s.executables  = %w( )

  s.require_path = 'lib'
  s.files = %w(Rakefile LICENSE README.md) + Dir.glob("{distro,lib,tasks,spec}/**/*", File::FNM_DOTMATCH).reject {|f| File.directory?(f) }
end
