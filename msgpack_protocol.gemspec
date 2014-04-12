# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'msgpack_protocol'

Gem::Specification.new do |spec|
  spec.name          = "msgpack_protocol"
  spec.version       = EventMachine::Protocols::MsgpackProtocol::VERSION
  spec.authors       = ["'Konstantin Makarchev'"]
  spec.email         = ["'kostya27@gmail.com'"]
  spec.summary       = %q{Msgpack protocol for eventmachine}
  spec.description   = %q{Msgpack protocol for eventmachine}
  spec.homepage      = "https://github.com/kostya/msgpack_protocol"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "eventmachine"
  spec.add_dependency "msgpack"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
