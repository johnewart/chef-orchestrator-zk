require 'chef_orchestrator_zk/orchestration_run_data'
require 'cheffish/recipe_dsl'

class Chef
  module DSL
    module Recipe

      # @param hostport [String] ZooKeeper host:port location
      def with_zookeeper(hostport, &block)
        run_context.orchestration.with_zookeeper(hostport, &block)
      end

      def shared_resource(name, &block)
        declare_resource(:zookeeper_lock, name, caller[0]) do
          action :create
        end
        block.call
        declare_resource(:zookeeper_lock, name, caller[0]) do
          action :delete
        end
      end

      def wait_for(name, &block)
        declare_resource(:zookeeper_lock, name, caller[0]) do
          action :wait
        end
      end

    end
  end

  class RunContext
    def orchestration
      @orchestration ||= ChefOrchestration::OrchestrationRunData.new(config)
    end
  end
end