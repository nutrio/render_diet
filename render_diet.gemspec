require './lib/render_diet/version'

Gem::Specification.new "render_diet", RenderDiet::VERSION do |gem|
  gem.authors       = ["Henning Koch", "Tobias Kraze", "Thomas Davis"]
  gem.email         = "render_diet@rudiment.net"
  gem.description   = "Rails view render counter that stays out of your way"
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/trak3r/render_diet"
  gem.license       = 'MIT'
  gem.files         = `git ls-files README.md MIT-LICENSE lib`.split($\)
  gem.required_ruby_version = '>= 2.0.0'
end

