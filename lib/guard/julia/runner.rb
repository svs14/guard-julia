module Guard
  class Julia
    # Runner that handles Julia calls and Guard notifications.
    class Runner
      # Options for runner.
      attr_accessor :options

      # Initializes Runner.
      #
      # @param options [Dict] Options for runner.
      def initialize(options = {})
        @options = {
          julia_file_path: 'julia',
          all_tests_file: 'test/runtests.jl',
          cli: ['--code-coverage'],
          env: {}
        }.merge(options)
      end

      # Runs Julia on all tests file and notifies.
      def run_all
        paths = [@options[:all_tests_file]]
        ret_code = run_julia_command(paths)
        guard_notify(paths, ret_code)
      end

      # Runs Julia on target paths (triggered by file modifications).
      #
      # @param paths [Array<String>] Paths of files.
      def run_on_modifications(paths)
        return_code = run_julia_command(paths)
        guard_notify(paths, return_code)
      end

      private

      # Runs Julia command from paths and options.
      # Returns system return code.
      def run_julia_command(paths)
        cmd_parts = build_julia_command(paths)
        system(@options[:env], *cmd_parts)
      end

      # Build Julia command from paths and options.
      # Returns array of command parts.
      def build_julia_command(paths)
        cmd_parts = []
        cmd_parts << "#{@options[:julia_file_path]}"
        cmd_parts.push(*@options[:cli])
        cmd_parts.push(*paths)

        cmd_parts
      end

      # Guard notification of Julia success/failure.
      def guard_notify(paths, success)
        # Build notification
        if success
          title = 'Success'
          message = paths.join('\n')
          image = :success
        else
          title = 'Failed'
          message = paths.join('\n')
          image = :failed
        end

        # Notify via Guard
        ::Guard::Notifier.notify(message, title: title, image: image)
      end
    end
  end
end
