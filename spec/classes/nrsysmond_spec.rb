require 'spec_helper'

describe 'nrsysmond' do
  let(:params) { {:license_key => '14758f1afd44c09b7992073ccf00b43d' }}

  # ['RedHat', 'Ubuntu'].each do |platform|
  ['RedHat'].each do |platform|
    context '#{platform} osfamily' do
      let(:facts) { {:osfamily => platform} }
      it { should include_class('nrsysmond::params')}

      it { should contain_package 'newrelic-sysmond'}

      it { should contain_class('nrsysmond::config').with(
        'license_key' => '14758f1afd44c09b7992073ccf00b43d',
        'nrlogfile'   => '/var/log/newrelic/nrsysmond.log',
        'nrloglevel'  => 'info'
      )}

      it { should contain_service 'newrelic-sysmond' }
    end
  end

  context 'Non-Ubuntu and non-RedHat osfamily' do
    it do
      expect {
        should include_class('nrsysmond::params')
      }.to raise_error(Puppet::Error, /not supported/)
    end
  end

end
