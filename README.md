# Guard::Julia

[![Gem Version](https://badge.fury.io/rb/guard-julia.png)](http://badge.fury.io/rb/guard-julia) 
[![Build Status](https://travis-ci.org/svs14/guard-julia.png?branch=master)](https://travis-ci.org/svs14/guard-julia)
[![Dependency Status](https://gemnasium.com/svs14/guard-julia.png)](https://gemnasium.com/svs14/guard-julia)
[![Code Climate](https://codeclimate.com/github/svs14/guard-julia.png)](https://codeclimate.com/github/svs14/guard-julia)
[![Coverage Status](https://coveralls.io/repos/svs14/guard-julia/badge.png?branch=master)](https://coveralls.io/r/svs14/guard-julia)
[![Inline docs](http://inch-ci.org/github/svs14/guard-julia.png)](http://inch-ci.org/github/svs14/guard-julia)

Julia guard automatically launches 
respective tests when Julia files are modified.

The codebase's architecture is largely derived from
[guard-minitest](https://github.com/guard/guard-minitest).

## Installation

Ruby must be installed, then run:

    $ gem install bundler
    $ cd /your/julia/project/dir
    $ bundle init

Add this line to your application's Gemfile:

    gem 'guard-julia'

And then execute:

    $ bundle

## Usage

Please read [Guard usage documentation](http://github.com/guard/guard#readme).

To create the Guardfile run:

    $ bundle exec guard init julia

Then run guard itself:

    $ bundle exec guard

## Options

```ruby
all_on_start: true # Run all tests on startup
julia_file_path: 'julia' # File path to Julia executable
all_tests_file: 'test/runtests.jl' # File to run all tests
cli: ['--code-coverage'] # CLI arguments to Julia
env: {} # Environment variables
```

You can pass any of these options to Guard like so:
```ruby
guard :julia, cli: ['--code-coverage', '-p 1'] do
  # ...
end
```

## Contributing

1. Fork it ( http://github.com/svs14/guard-julia/fork )
2. Get all dependencies (`bundle`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Make sure tests pass (`bundle exec rake test`)
6. Follow RuboCop's advice (`bundle exec rubocop`)
7. Push to the branch (`git push origin my-new-feature`)
8. Create new Pull Request
