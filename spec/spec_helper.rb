require 'rubygems'

if ENV['CI']
  require 'coveralls'
  Coveralls.wear! do
    add_filter 'spec'
  end
end

ENV['GUARD_ENV'] = 'test'
require 'guard/julia'

require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'

module MiniTest
  #
  class Spec
    before(:each) do
      # Stub all UI methods, so no visible output appears for the UI class
      ::Guard::UI.stubs(:info)
      ::Guard::UI.stubs(:warning)
      ::Guard::UI.stubs(:error)
      ::Guard::UI.stubs(:debug)
      ::Guard::UI.stubs(:deprecation)
    end
  end
end
