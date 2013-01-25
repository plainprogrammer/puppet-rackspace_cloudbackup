#!/usr/bin/env rspec
require 'spec_helper'

describe 'rackspace_cloudbackup' do
  let(:required_params) { { :api_username => 'example', :api_key => 'A_VALID_KEY' } }

  describe 'requires api_username parameter' do
    let(:params) { required_params.delete_if {|k,v| k == :api_username } }

    it { expect { subject }.to raise_error(/The api_username parameter is required\./) }
  end

  describe 'requires api_key parameter' do
    let(:params) { required_params.delete_if {|k,v| k == :api_key } }

     it { expect { subject }.to raise_error(/The api_key parameter is required\./) }
  end

  describe 'on Debian based systems' do
    let(:params) { required_params }
    let(:facts) { { :osfamily => 'Debian' } }

    it { should contain_package('driveclient').with_ensure('present') }

    it { should contain_service('driveclient').with_ensure('running') }
    it { should contain_service('driveclient').with_enable('true') }

    describe 'when use_latest is true' do
      let(:params) { required_params.merge({ :use_latest => true }) }

      it { should contain_package('driveclient').with_ensure('latest') }
    end
  end

  describe 'on RHEL based systems' do
    let(:params) { required_params }

    let(:facts) { { :osfamily => 'RedHat' } }

    it { should contain_package('driveclient').with_ensure('present') }

    it { should contain_service('driveclient').with_ensure('running') }
    it { should contain_service('driveclient').with_enable('true') }

    describe 'when use_latest is true' do
      let(:params) { required_params.merge({ :use_latest => true }) }

      it { should contain_package('driveclient').with_ensure('latest') }
    end
  end

  describe 'on unsupported systems' do
    let(:params) { required_params }
    let(:facts) { { :osfamily => 'Unsupported' } }

    it { expect { subject }.to raise_error(/The rackspace_driveclient module does not support Unsupported\./) }
  end
end
