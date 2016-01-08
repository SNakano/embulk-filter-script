Gem::Specification.new do |s|
  s.name          = "embulk-filter-script"
  s.version       = "0.0.1"
  s.licenses      = ["MIT"]
  s.summary       = "Embulk filter plugin to external ruby script"
  s.description   = s.summary
  s.authors       = ["SNakano"]
  s.email         = ["pp.nakano@gmail.com"]
  s.homepage      = "https://github.com/SNakano/embulk-filter-script"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency 'embulk', '~> 0.7.9'
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rake', '~> 10.0'
end
