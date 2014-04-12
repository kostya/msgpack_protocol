# MsgpackProtocol
Msgpack protocol for eventmachine

Install:

    gem install msgpack_protocol

Usage:

```ruby
class Server < EM::Connection
  include EM::P::MsgpackProtocol

  def receive_object obj
    send_object({'you said' => obj})
  end
end
```
