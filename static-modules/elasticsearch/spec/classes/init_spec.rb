require 'spec_helper'

describe 'elasticsearch' do
  let(:facts) {{ 
    :kernel => 'linux', 
    :operatingsystem => 'ubuntu',
    :lsbdistcodename => 'natty', 
    :lsbdistid       => 'ubuntu',
    :osfamily        => 'debian' 
  }}
  it { should contain_package('openjdk-7-jre').with_ensure('present') }
  it { should contain_service('elasticsearch').with_ensure('running') }
end
