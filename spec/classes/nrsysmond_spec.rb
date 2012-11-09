require 'spec_helper'

describe 'nrsysmond' do
  let(:params) { {:license_key => 'asdfdsa51c05cbdcc1dc3e78fa981c2f4790e6902fd1c4f' }}

  context 'Invalid license key' do
    let(:params) { {:license_key => 'foobar' }}

      it {
        expect {
          should include_class('nrsysmond::params')
        }.to raise_error(Puppet::Error, /40 character hexadecimal/)
      }
  end

  ['RedHat', 'Debian'].each do |platform|
    context "#{platform} osfamily" do
      let(:facts) { {:osfamily => platform} }
      it { should include_class('nrsysmond::params')}

      it { should contain_package 'newrelic-sysmond'}

      it { should contain_class('nrsysmond::config').with(
        'license_key' => 'asdfdsa51c05cbdcc1dc3e78fa981c2f4790e6902fd1c4f',
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
