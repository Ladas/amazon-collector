$:.push File.expand_path("../lib", __FILE__)

require "topological_inventory-collector-amazon/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "topological_inventory-collector-amazon"
  s.version     = OpenshiftCollector::VERSION
  s.authors     = ["Ladislav Smoila"]
  s.email       = ["lsmola@redhat.com"]
  s.homepage    = "https://github.com/lsmola/topological_inventory-collector-amazon"
  s.summary     = "Amazon AWS collector for the Topological Inventory Service."
  s.description = "Amazon AWS collector for the Topological Inventory Service."
  s.license     = "Apache-2.0"

  s.files = Dir["{lib}/**/*"]

  s.add_dependency "activesupport"
  s.add_dependency "aws-sdk", "~>3.0.0"
  s.add_dependency "concurrent-ruby"
  s.add_dependency "more_core_extensions"
  s.add_dependency "optimist"
end
