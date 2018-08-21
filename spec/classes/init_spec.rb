require 'spec_helper'
describe 'pgbouncer' do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('pgbouncer') }
    it { is_expected.to contain_class('pgbouncer::prepare') }
    it { is_expected.to contain_class('pgbouncer::install') }
    it { is_expected.to contain_class('pgbouncer::config') }
    it { is_expected.to contain_class('pgbouncer::userlist') }
    it { is_expected.to contain_class('pgbouncer::service') }
  end
end
