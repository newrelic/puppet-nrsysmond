require 'spec_helper'

describe 'nrsysmond' do
  let(:params) { {:license_key => '0123456789ABCDEFabcdef2345678901234567Zz' }}

  shared_examples_for 'Invalid license key' do
    let(:facts) { {:osfamily => 'RedHat' }}
      it {
        expect {
          should contain_class('nrsysmond::params')
        }.to raise_error(Puppet::Error, /40 character alphanumeric/)
      }
  end

  context 'the license key is too short' do
    let(:params) { {:license_key => 'foobar' }}

    it_behaves_like 'Invalid license key'
  end

  context 'the license key is too long' do
    let(:params) { {:license_key => 'asdfdsa51c05cbdcc1dc3e78fa981c2f4790e6902fd1c4Z' }}

    it_behaves_like 'Invalid license key'
  end

  context 'the license key contains 40 non-alphanumeric characters' do
    let(:params) { {:license_key => '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$' }}

    it_behaves_like 'Invalid license key'
  end

  context 'when enabled set to true' do
    let(:facts) { {:osfamily => 'RedHat' }}
    let(:params) { {
      :license_key => '0123456789ABCDEFabcdef2345678901234567Zz',
      :enabled     => true
    }}

    it { should contain_service('newrelic-sysmond').with(
      'enable' => true,
      'ensure' => 'running'
    )}
  end
  context 'when enabled set to false' do
    let(:facts) { {:osfamily => 'RedHat' }}
    let(:params) { {
      :license_key => '0123456789ABCDEFabcdef2345678901234567Zz',
      :enabled     => false
    }}

    it { should contain_service('newrelic-sysmond').with(
      'enable' => false,
      'ensure' => 'stopped'
    )}
  end

  ['RedHat', 'Debian'].each do |platform|
    context "#{platform} osfamily" do
      let(:facts) { {:osfamily => platform} }
      it { should contain_class('nrsysmond::params')}

      it { should contain_package 'newrelic-sysmond'}

      it { should contain_class('nrsysmond::config').with(
        'license_key' => '0123456789ABCDEFabcdef2345678901234567Zz',
        'nrlogfile'   => '/var/log/newrelic/nrsysmond.log',
        'nrloglevel'  => 'error'
      )}
    end
  end

  context 'Non-Ubuntu and non-RedHat osfamily' do
    it do
      expect {
        should contain_class('nrsysmond::params')
      }.to raise_error(Puppet::Error, /not supported/)
    end
  end

end
