require File.dirname(__FILE__) + '/spec_helper'
require 'eventmachine'

class Server < EM::Connection
  include EM::P::MsgpackProtocol

  def receive_object(obj)
    $server_obj = obj
    send_object(obj)
  end
end

class Client < EM::Connection
  include EM::P::MsgpackProtocol

  def receive_object(obj)
    $client_obj = obj
    EM.stop
  end
end

def send_and_receive(obj)
  EM.run do
    EM.start_server '127.0.0.1', 12346, Server
    EM.connect '127.0.0.1', 12346, Client do |cn|
      cn.send_object(obj)
    end
  end
end

describe "main" do
  it "should work with string" do
    obj = "bla"
    send_and_receive(obj)
    $client_obj.should == obj
    $server_obj.should == obj
  end

  it "should work struct" do
    obj = ["bla", {'bla' => 12, [] => 19, [3,4] => [false,true]}]
    send_and_receive(obj)
    $client_obj.should == obj
    $server_obj.should == obj
  end

  it "should work super big data" do
    obj = ['a'] * 300_000
    send_and_receive(obj)
    $client_obj.size.should == obj.size
    $server_obj.size.should == obj.size
  end

  it "should work big string" do
    obj = 'a' * 10_000_000
    send_and_receive(obj)
    $client_obj.size.should == obj.size
    $server_obj.size.should == obj.size
  end

end
