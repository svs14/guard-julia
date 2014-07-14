require 'spec_helper'

describe Guard::Julia::Runner do
  subject { Guard::Julia::Runner }

  let(:default_options) do
    {
      julia_file_path: 'julia',
      all_tests_file: 'test/runtests.jl',
      cli: ['--code-coverage'],
      env: {}
    }
  end

  describe '#options' do
    it 'defaults' do
      subject.new.options.must_equal(default_options)
    end
  end

  describe '#run_all' do
    it 'runs all tests file' do
      subject.any_instance.expects(:system).with(
        {}, 'julia', '--code-coverage', 'test/runtests.jl'
      ).returns(true)
      ::Guard::Notifier.expects(:notify).with(
        'test/runtests.jl', title: 'Success', image: :success
      )
      subject.new.run_all
    end
  end
  describe '#run_on_modifications' do
    describe 'when julia exits successfully' do
      it 'it notifies success' do
        subject.any_instance.expects(:system).with(
          {}, 'julia', '--code-coverage',
          'test/test_example.jl', 'test/test_dummy.jl'
        ).returns(true)
        ::Guard::Notifier.expects(:notify).with(
          'test/test_example.jl\ntest/test_dummy.jl',
          title: 'Success', image: :success
        )

        subject.new.run_on_modifications(
          ['test/test_example.jl', 'test/test_dummy.jl']
        )
      end
    end

    describe 'when julia exits with failure' do
      it 'it notifies failure' do
        subject.any_instance.expects(:system).with(
          {}, 'julia', '--code-coverage',
          'test/test_example.jl', 'test/test_dummy.jl'
        ).returns(false)
        ::Guard::Notifier.expects(:notify).with(
          'test/test_example.jl\ntest/test_dummy.jl',
          title: 'Failed', image: :failed
        )

        subject.new.run_on_modifications(
          ['test/test_example.jl', 'test/test_dummy.jl']
        )
      end
    end
  end
end
