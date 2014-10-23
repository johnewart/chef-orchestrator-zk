class Chef::Provider::SleepTimer < Chef::Provider::LWRPBase

  def report_progress message
    converge_by message do
    end
  end

  def initialize(new_resource, run_context)
    super
  end

  action :create do
    sleep_time = new_resource.length || 10
    report_progress "Sleeping for #{sleep_time} seconds..."
    sleep sleep_time
  end

end
