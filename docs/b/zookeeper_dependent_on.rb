require 'chef_orchestrator_zk'

with_zookeeper "localhost:2182" do
  wait_for 'my_test_service' do
    file '/tmp/foo.txt' do
      content "UNLOCKED!"
    end
  end
end

