module ChefOrchestration
  class OrchestrationRunData

    def initialize(config)
      @config = config
    end

    attr_accessor :current_zookeeper

    def with_zookeeper(hostport)
      old_value = self.current_zookeeper
      self.current_zookeeper = hostport
      if block_given?
        begin
          yield
        ensure
          self.current_zookeeper = old_value
        end
      end
    end
  end
end


