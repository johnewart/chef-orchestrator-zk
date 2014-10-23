require 'chef_orchestrator_zk'

with_zookeeper "localhost:2182" do 
  shared_resource 'my_test_service' do 
    sleep_timer "sleeper" do
      length 10
    end
  end
end



