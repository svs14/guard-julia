require 'guard'
require 'guard/plugin'

module Guard
  # Guard plugin for the Julia language.
  class Julia < Plugin
    require 'guard/julia/version'
    require 'guard/julia/runner'

    # Options for plugin.
    attr_accessor :options
    # Runner that handles Julia commands.
    attr_accessor :runner

    def initialize(options = {})
      super

      @options = {
        all_on_start: true
      }.merge(options)
      @runner = Runner.new(@options)
    end

    def start
      UI.info "Guard::Julia #{JuliaVersion::VERSION} is running"
      run_all if @options[:all_on_start]
    end

    def stop
      true
    end

    def reload
      true
    end

    def run_all
      UI.info 'Running: all tests', reset: true
      throw_on_failed_tests { runner.run_all }
    end

    def run_on_changes(_)
      true
    end

    def run_on_additions(_)
      true
    end

    def run_on_modifications(paths)
      UI.info "Running: #{paths.join(', ')}", reset: true
      throw_on_failed_tests { runner.run_on_modifications(paths) }
    end

    def run_on_removals(_)
      true
    end

    private

    # Runs block and throws :task_has_failed
    # when return is false.
    def throw_on_failed_tests
      throw :task_has_failed unless yield
    end
  end
end
