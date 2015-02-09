require 'spec_helper'

describe 'nrsysmond' do
  let(:params) { {:license_key => 'asdfdsa51c05cbdcc1dc3e78fa981c2f4790e6902fd1c4f' }}

  context 'Invalid license key' do
    let(:params) { {:license_key => 'foobar' }}
    let(:facts) { {:osfamily => 'RedHat' }}
      it {
        expect {
          should contain_class('nrsysmond::params')
        }.to raise_error(Puppet::Error, /40 character hexadecimal/)
      }
  end

  ['RedHat', 'Debian'].each do |platform|
    context "#{platform} osfamily" do
      let(:facts) { {:osfamily => platform} }
      it { should compile.with_all_deps }

      it { should contain_class('nrsysmond::params')}

      it { should contain_package 'newrelic-sysmond'}

      it { should contain_class('nrsysmond::config').with(
        'license_key' => 'asdfdsa51c05cbdcc1dc3e78fa981c2f4790e6902fd1c4f',
        'nrlogfile'   => '/var/log/newrelic/nrsysmond.log',
        'nrloglevel'  => 'error'
      )}

      it { should contain_service 'newrelic-sysmond' }
    end
  end

  context "without SELinux" do
    let(:facts) {{:osfamily => 'RedHat', :selinux => 'false'}}
    describe 'should not manage user' do
      it { should compile.with_all_deps }
      it { should_not contain_group('newrelic') }
      it { should_not contain_user('newrelic') }
      it { should contain_package('newrelic-sysmond').with(
                    :require => 'Class[Nrsysmond::Repo::Redhat]',
      )}
    end
  end

  context "with SELinux" do
    let(:facts) {{:osfamily => 'RedHat', :selinux => 'true'}}
    describe 'should manage user' do
      it { should compile.with_all_deps }
      it { should contain_group('newrelic').with(
                    :ensure     => 'present',
                    :forcelocal => true,
                    :system     => true,
      )}
      it { should contain_user('newrelic').with(
                    :ensure     => 'present',
                    :comment    => 'New Relic daemons',
                    :forcelocal => true,
                    :gid        => 'newrelic',
                    :home       => '/.newrelic',
                    :managehome => true,
                    :shell      => '/sbin/nologin',
                    :system     => true,
                    :require    => 'Group[newrelic]',
      )}
      it { should contain_package('newrelic-sysmond').with(
                    :require => ['Class[Nrsysmond::Repo::Redhat]', 'User[newrelic]'],
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
