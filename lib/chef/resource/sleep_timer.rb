class Chef::Resource::SleepTimer < Chef::Resource::LWRPBase
  self.resource_name = 'sleep_timer'

  actions :create, :delete, :wait
  default_action :create

  attribute :name, :kind_of => String, :name_attribute => true
  attribute :length, :kind_of => Integer

  def initialize(*args)
    super
  end

  def after_created
    super
  end
end
