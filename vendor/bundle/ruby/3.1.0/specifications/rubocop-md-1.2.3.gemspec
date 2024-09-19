# -*- encoding: utf-8 -*-
# stub: rubocop-md 1.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rubocop-md".freeze
  s.version = "1.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "http://github.com/rubocop/rubocop-md/issues", "changelog_uri" => "https://github.com/rubocop/rubocop-md/blob/master/CHANGELOG.md", "documentation_uri" => "https://github.com/rubocop/rubocop-md/blob/master/README.md", "homepage_uri" => "https://github.com/rubocop/rubocop-md", "source_code_uri" => "http://github.com/rubocop/rubocop-md" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vladimir Dementyev".freeze]
  s.date = "2024-09-13"
  s.description = "Run Rubocop against your Markdown files to make sure that code examples follow style guidelines.".freeze
  s.email = ["dementiev.vm@gmail.com".freeze]
  s.homepage = "https://github.com/rubocop/rubocop-md".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.0".freeze)
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Run Rubocop against your Markdown files to make sure that code examples follow style guidelines.".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rubocop>.freeze, [">= 1.45"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.15"])
    s.add_development_dependency(%q<rake>.freeze, [">= 13.0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
  else
    s.add_dependency(%q<rubocop>.freeze, [">= 1.45"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.15"])
    s.add_dependency(%q<rake>.freeze, [">= 13.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
  end
end
