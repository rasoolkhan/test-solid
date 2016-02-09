# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "handlebars_assets/version"

Gem::Specification.new do |s|
  s.name        = "handlebars_assets"
  s.version     = HandlebarsAssets::VERSION
  s.authors     = ["Les Hill"]
  s.licenses    = ["MIT"]
  s.email       = ["leshill@gmail.com"]
  s.homepage    = "https://github.com/leshill/handlebars_assets"
  s.summary     = "Compile Handlebars templates in the Rails asset pipeline."
  s.description = "Compile Handlebars templates in the Rails asset pipeline."

  s.rubyforge_project = "handlebars_assets"

  s.files         = [".gitignore", ".ruby-gemset", "CHANGELOG.md", "Gemfile", "MIT-LICENSE", "README.md", "Rakefile", "handlebars_assets.gemspec", "lib/handlebars_assets.rb", "lib/handlebars_assets/config.rb", "lib/handlebars_assets/engine.rb", "lib/handlebars_assets/handlebars.rb", "lib/handlebars_assets/handlebars_template.rb", "lib/handlebars_assets/version.rb", "test/edge/handlebars.js", "test/handlebars_assets/compiling_test.rb", "test/handlebars_assets/hamlbars_test.rb", "test/handlebars_assets/slimbars_test.rb", "test/handlebars_assets/tilt_handlebars_test.rb", "test/patch/patch.js", "test/test_helper.rb", "vendor/assets/javascripts/handlebars.js", "vendor/assets/javascripts/handlebars.runtime.js"]
  s.test_files    = ["test/edge/handlebars.js", "test/handlebars_assets/compiling_test.rb", "test/handlebars_assets/hamlbars_test.rb", "test/handlebars_assets/slimbars_test.rb", "test/handlebars_assets/tilt_handlebars_test.rb", "test/patch/patch.js", "test/test_helper.rb"]
  s.executables   = []
  s.require_paths = ["lib"]

  s.add_runtime_dependency "execjs", ">= 1.2.9"
  s.add_runtime_dependency "tilt"
  s.add_runtime_dependency "multi_json"
  s.add_runtime_dependency "sprockets", ">= 2.0.3"

  s.add_development_dependency "minitest"
  s.add_development_dependency "haml"
  s.add_development_dependency "rake"
  s.add_development_dependency "slim"
  s.add_development_dependency 'json', '~> 1.7.7'
end
