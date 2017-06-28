require 'spec_helper'
describe 'ntp_master_slave' do
  context 'with default values for all parameters' do
    it { should contain_class('ntp_master_slave') }
  end
end
