require_relative "lib/lintity/version"

Gem::Specification.new do |spec|
  spec.name        = "lintity"
  spec.version     = Lintity::VERSION
  spec.authors     = ["Fat Shinobi"]
  spec.email       = ["r3mnik@gmail.com"]
  spec.homepage    = "https://github.com/fatshinobi/lintity"
  spec.summary     = "Rails gem to create list of entities"
  spec.description = "Rails gem to create list of entities"
    spec.license     = "MIT"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #spec.metadata["allowed_push_host"] = "https://rubygems.org/gems/lintity"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fatshinobi/lintity"
  spec.metadata["changelog_uri"] = "https://github.com/fatshinobi/lintity"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_runtime_dependency "rails", "~> 7.0", ">= 7.0.2.3"
  spec.add_dependency 'importmap-rails'
  
end
