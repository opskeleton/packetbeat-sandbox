require 'spec_helper'

describe 'kibana3' do
  it { should compile }
  let(:facts) {{ 
    :kernel    => 'linux',
    :osfamily  => 'debian',
    :lsbdistid  => 'ubuntu',
    :lsbdistcodename => 'natty', 
    :operatingsystem => 'ubuntu', 
    :concat_basedir => '/tmp/'
  }}
  it { should contain_package('curl').with_ensure('present') }
  it { should contain_package('unzip').with_ensure('present') }
end
