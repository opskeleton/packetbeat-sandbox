require 'spec_helper'
describe 'packerbeat' do

  context 'with defaults for all parameters' do
    it { should contain_class('packerbeat') }
  end
end
