require 'spec_helper'

describe Guard::Julia do
  subject { Guard::Julia }

  let(:runner) { Guard::Julia::Runner }
  let(:guard) { subject.new }

  describe '#initialize' do
    it 'passes options to runner' do
      runner.expects(:new).with(all_on_start: true)
      subject.new
    end
  end

  describe '#start' do
    describe 'when using defaults' do
      it 'runs all tests' do
        subject.any_instance.expects(:run_all)
        subject.new.start
      end
    end
    describe 'when run_all_on_start: false' do
      it 'does not run all tests' do
        subject.any_instance.expects(:run_all).never
        subject.new(all_on_start: false).start
      end
    end
  end
  describe '#stop' do
    it 'returns true' do
      guard.stop.must_equal true
    end
  end
  describe '#reload' do
    it 'returns true' do
      guard.reload.must_equal true
    end
  end

  describe '#run_all' do
    it 'delegates to runner, then notifies' do
      runner.any_instance.expects(run_all: true)
      Guard::UI.expects(:info).with(
        'Running: all tests',
        reset: true
      )
      guard.run_all
    end
  end

  describe '#run_on_changes' do
    it 'returns true' do
      guard.run_on_changes([]).must_equal true
    end
  end
  describe '#run_on_removals' do
    it 'returns true' do
      guard.run_on_removals([]).must_equal true
    end
  end
  describe '#run_on_additions' do
    it 'returns true' do
      guard.run_on_additions([]).must_equal true
    end
  end

  describe '#run_on_modifications' do
    it 'delegates to runner, then notifies' do
      runner.any_instance.expects(run_on_modifications: true)
      Guard::UI.expects(:info).with(
        'Running: test/test_example.jl, test/test_dummy.jl',
        reset: true
      )
      guard.run_on_modifications(['test/test_example.jl', 'test/test_dummy.jl'])
    end
  end
end
