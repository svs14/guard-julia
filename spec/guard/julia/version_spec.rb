require 'spec_helper'

describe Guard::JuliaVersion do
  subject { Guard::JuliaVersion }

  describe '::VERSION' do
    it 'provides the version' do
      subject::VERSION.must_match(/^[0-9]+\.[0-9]+\.[0-9]+/)
    end
  end
end
