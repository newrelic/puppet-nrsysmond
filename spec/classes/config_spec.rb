require 'spec_helper'

describe 'nrsysmond::config' do
  context 'with valid osfamily' do
    let(:facts) { {:osfamily => 'RedHat', :hardwaremodel => 'x86_64'} }

    context 'and no hostname does not include hostname in cfg' do
      let(:params) {
        {
          :license_key  => '0123456789ABCDEFabcdef2345678901234567Zz',
        }
      }

      it {
        should contain_file('/etc/newrelic/nrsysmond.cfg') \
          .without_content(/hostname=/)
      }
    end

    context 'and hostname includes hostname in cfg' do
      let(:params) {
        {
          :license_key  => '0123456789ABCDEFabcdef2345678901234567Zz',
          :hostname     => 'foo.newrelic.com',
        }
      }

      it {
        should contain_file('/etc/newrelic/nrsysmond.cfg') \
          .with_content(/^hostname=foo.newrelic.com$/)
      }
    end

  end

end
