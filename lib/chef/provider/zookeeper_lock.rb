require 'zk'

class Chef::Provider::ZookeeperLock < Chef::Provider::LWRPBase

  attr_reader :zk

  def report_progress message
    converge_by message do

    end
  end

  def initialize(new_resource, run_context)
    super
    Chef::Log.debug "Connecting to ZooKeeper on #{new_resource.zk_hostport}"
    @zk = ZK.new(new_resource.zk_hostport)
  end

  def block_until_node_deleted(abs_node_path)
    queue = Queue.new

    ev_sub = zk.register(abs_node_path) do |event|
      if event.node_deleted?
        # trigger queue's #pop to unblock us
        queue.enq(:deleted)
      else
        if zk.exists?(abs_node_path, :watch => true)
          # node exists, re-watch wait for next event
          # i.e it was created, or updated, but not removed
        else
          # trigger queue's #pop to unblock us
          queue.enq(:deleted)
        end
      end
    end

    # set up the callback
    # (if you don't call exists? the watch doesn't get set)
    zk.exists?(abs_node_path, :watch => true)

    queue.pop # block waiting for node deletion
    true
  ensure
    ev_sub.unsubscribe
  end

  action :wait do
    path = "/#{new_resource.name}"
    report_progress "Dependent on completion of #{path}, waiting..."
    block_until_node_deleted(path)
    report_progress "#{path} unlocked, continuing..."
  end

  action :create do
    path = "/#{new_resource.name}"
    report_progress "#{new_resource.name} locking #{path}..."
    @zk.create(path, sequence: false, ephemeral: true)
  end

  action :delete do
    path = "/#{new_resource.name}"
    @zk.delete(path)
    report_progress "Lock at #{path} deleted!"
  end

end
