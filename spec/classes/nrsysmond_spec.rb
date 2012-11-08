require 'spec_helper'

describe 'nrsysmond' do
  context 'RedHat osfamily' do
    let(:facts) { {:osfamily => 'RedHat'} }
    it { should include_class('nrsysmond::params')}
  end

  context 'Non-Ubuntu and non-RedHat osfamily' do
    it do
      expect {
        should include_class('nrsysmond::params')
      }.to raise_error(Puppet::Error, /not supported/)
    end
  end
end
