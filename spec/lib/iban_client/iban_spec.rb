require 'spec_helper'

describe IbanClient::Iban, iban: true do
  let(:iban) { 'FR7616798000010000005663951' }
  subject { described_class.new(iban) }

  describe 'attributes' do
    it { expect(subject.bic).to eq('TRZOFR21') }
    it { expect(subject.bank).to eq('TREEZOR SAS') }
    it { expect(subject.address).to eq('150 RUE GALLIENI') }
    it { expect(subject.city).to eq('BOULOGNE BILLANCOURT CEDEX') }
    it { expect(subject.state).to be_nil }
    it { expect(subject.zip).to eq('92641') }
    it { expect(subject.country).to eq('FRANCE') }
    it { expect(subject.country_iso).to eq('FR') }
    it { expect(subject.bic).to eq('TRZOFR21') }
    it { expect(subject.account).to eq('00000056639') }

    it 'returns a hash of attributes' do
      expect(subject.attributes).to eq({
        "account" => "00000056639",
        "address" => "150 RUE GALLIENI",
        "bank" => "TREEZOR SAS",
        "bic" => "TRZOFR21",
        "branch" => nil,
        "city" => "BOULOGNE BILLANCOURT CEDEX",
        "country" => "FRANCE",
        "country_iso" => "FR",
        "email" => nil,
        "fax" => nil,
        "phone" => nil,
        "state" => nil,
        "www" => nil,
        "zip" => "92641",
        "iban" => "FR7616798000010000005663951"
      })
    end

    context 'with account error' do
      before do
        IbanClient.api_key = 'invalid_key'
      end

      after do
        IbanClient.api_key = nil
      end

      it { expect { subject.bic }.to raise_error(IbanClient::AccountError) }
    end

    context 'with a request error' do
      let(:iban) { 'raise' }
      it { expect { subject.bic }.to raise_error(IbanClient::RequestError) }
    end

    context 'with an invalid error' do
      let(:iban) { 'invalid_json' }
      it { expect { subject.bic }.to raise_error(IbanClient::RequestError) }
    end

    context 'with an unexpected error' do
      before do
        allow(RestClient::Request).to receive(:execute).and_raise(StandardError, "Cant connect")
      end
      it { expect { subject.bic }.to raise_error(IbanClient::RequestError, /Response: Cant connect/) }
    end
  end

  describe 'sepa_data' do
    it { expect(subject).to be_sct }
    it { expect(subject).to be_sdd }
    it { expect(subject).to be_cor1 }
    it { expect(subject).not_to be_b2b }
    it { expect(subject).not_to be_scc }
  end

  describe 'validation' do
    it { expect(subject).to be_valid }
    it { expect(subject.errors).to eq([]) }

    context 'with invalid iban' do
      let(:iban) { 'foo' }
      it { expect(subject).not_to be_valid }
      it { expect(subject.errors).to contain_exactly(:invalid_account_number, :invalid_iban_digit) }
    end

    context 'with api errors' do
      before do
        IbanClient.api_key = 'invalid_key'
      end

      after do
        IbanClient.api_key = nil
      end

      it { expect { subject.valid? }.to raise_error(IbanClient::AccountError) }
    end
  end
end
