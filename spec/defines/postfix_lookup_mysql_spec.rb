require 'spec_helper'

describe 'postfix::lookup::mysql' do
  let(:title) do
    '/etc/postfix/test.cf'
  end

  let(:params) do
    {
      :hosts    => ['localhost'],
      :user     => 'user',
      :password => 'password',
      :dbname   => 'database',
      :query    => "SELECT address FROM aliases WHERE alias = '%s'",
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'without postfix class included' do
        it { expect { should compile }.to raise_error(/must include the postfix base class/) }
      end

      context 'with postfix class included', :compile do
        let(:pre_condition) do
          'include ::postfix'
        end

        it { should contain_file('/etc/postfix/test.cf') }
        it { should contain_postfix__lookup__mysql('/etc/postfix/test.cf') }
      end
    end
  end
end
