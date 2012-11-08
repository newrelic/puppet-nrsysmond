require 'spec_helper'

describe 'nrsysmond' do
  let(:params) { {:license_key => '14758f1afd44c09b7992073ccf00b43d' }}

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
