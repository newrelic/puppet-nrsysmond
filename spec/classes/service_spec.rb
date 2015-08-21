require 'spec_helper'

describe 'nrsysmond::service' do

  context 'when enabled set to true' do
    let(:params) { {:enabled => true }}

    it { should contain_service('newrelic-sysmond').with(
      'enable' => true,
      'ensure' => true
    )}
  end
  context 'when enabled set to false' do
    let(:params) { {:enabled => false }}

    it { should contain_service('newrelic-sysmond').with(
      'enable' => false,
      'ensure' => false
    )}
  end
end
