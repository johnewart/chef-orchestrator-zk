require 'chef_orchestrator_zk'

class Chef::Resource::ZookeeperLock < Chef::Resource::LWRPBase
  self.resource_name = 'zookeeper_service'

  actions :create, :delete, :wait
  default_action :create

  attribute :name, :kind_of => String, :name_attribute => true
  attribute :zk_hostport, :kind_of => String

  def initialize(*args)
    super
    @zk_hostport = run_context.orchestration.current_zookeeper
  end

  def after_created
    super
  end
end
