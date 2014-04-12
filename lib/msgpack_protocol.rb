require 'msgpack'

module EventMachine
  module Protocols
    # MsgpackProtocol allows for easy communication using marshaled ruby objects
    #
    #  module RubyServer
    #    include EM::P::MsgpackProtocol
    #
    #    def receive_object obj
    #      send_object({'you said' => obj})
    #    end
    #  end
    #
    module MsgpackProtocol
      VERSION = '0.0.1'

      def initialize
        super
        @pac ||= MessagePack::Unpacker.new
      end

      # @private
      def receive_data data
        @pac.feed_each(data) { |obj| receive_object obj }
      end

      # Invoked with ruby objects received over the network
      def receive_object obj
        # stub
      end

      # Sends a ruby object over the network
      def send_object obj
        send_data MessagePack::Packer.new.pack(obj).to_s
      end
    end
  end
end
