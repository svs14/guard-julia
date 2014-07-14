source 'https://rubygems.org'

gemspec

gem 'rake'

group :development, :test do
  gem 'minitest'
  gem 'mocha'
  gem 'guard-minitest', require: false
  gem 'guard-rubocop', require: false
end

# Test group will be installed
# on Travis CI
group :test do
  gem 'coveralls', require: false
end
