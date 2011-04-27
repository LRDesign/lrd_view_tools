Gem::Specification.new do |s|
  s.name = %q{lrd_view_tools}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Evan Dorn"]
  s.date = %q{2011-04-27}
  s.summary = %q{View helpers and defaults for LRD projects.}
  s.description = %q{View helpers and defaults for LRD projects.  Compatible with Rails 3.x. Don't even bother trying with Rails 2.x or before.'}
  s.email = %q{evan@lrdesign.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE.txt",
    "README.rdoc",
  ]
  s.files		+= Dir.glob("lib/**/*")
  s.files		+= Dir.glob("templates/**/*")
  # s.files   += Dir.glob("doc/**/*")
  s.files   += Dir.glob("spec/**/*")

  s.homepage = %q{http://LRDesign.com}
  s.licenses = ["MIT"]
  s.require_paths = ["lib/"]
  s.rubygems_version = %q{1.3.5}
end

