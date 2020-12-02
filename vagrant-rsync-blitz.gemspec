# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vagrant-rsync-blitz/version"

Gem::Specification.new do |spec|
  spec.name          = "vagrant-rsync-blitz"
  spec.version       = VagrantPlugins::RsyncBlitz::VERSION
  spec.authors       = ["Steven Merrill", "Mitchell Nemitz"]
  spec.email         = ["steven.merrill@gmail.com", "mitchell.nemitz@gmail.com"]
  spec.summary       = %q{A lighter-weight Vagrant plugin for watching and rsyncing directories.}
  spec.description   = %q{The rsync-blitz plugin runs on Mac and Linux and is far less CPU-intensive than the built-in rsync-auto.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.start_with?("example/files")}
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
