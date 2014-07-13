require "guard"
require "guard/plugin"

module Guard
  class Julia < Plugin
    require "guard/julia/version"
    require "guard/julia/runner"

    attr_accessor :options
    attr_accessor :runner

    def initialize(options = {})
      super

      @options = {
        all_on_start: true
      }.merge(options)
      @runner = Runner.new(@options)
    end

    def start
      UI.info "Guard::Julia #{Julia::VERSION} is running"
      run_all if @options[:all_on_start]
    end

    def stop
      true
    end

    def reload
      true
    end

    def run_all
      UI.info("Running: all tests", reset: true)
      throw_on_failed_tests { runner.run_all }
    end

    def run_on_changes(paths)
      true
    end

    def run_on_additions(paths)
      true
    end

    def run_on_modifications(paths)
      UI.info("Running: #{paths.join(' ')}", reset: true)
      throw_on_failed_tests { runner.run_on_modifications(paths) }
    end

    def run_on_removals(paths)
      true
    end

    private

    def throw_on_failed_tests
      throw :task_has_failed unless yield
    end

  end
end
