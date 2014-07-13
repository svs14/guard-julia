module Guard
  class Julia
    class Runner
      attr_accessor :options

      def initialize(options = {})
        @options = {
          julia_file_path: "julia",
          all_tests_file: "test/runtests.jl",
          cli: ["--code-coverage"],
          env: {}
        }.merge(options)
      end

      def run_all
        run_julia_command([@options[:all_tests_file]])
      end
      def run_on_modifications(paths)
        run_julia_command(paths)
      end

      private

      def run_julia_command(paths)
        cmd_parts = build_julia_command(paths)
        system(*cmd_parts)
      end

      def build_julia_command(paths)
        cmd_parts = []
        cmd_parts << "#{@options[:julia_executable_path]}"
        cmd_parts.unshift(*@options[:cli])
        cmd_parts.unshift(*paths)
      end
    end
  end
end
