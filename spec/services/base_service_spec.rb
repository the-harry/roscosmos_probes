# frozen_string_literal: true

require 'rails_helper'

describe BaseService do
  describe '.call' do
    let(:arguments) { double('service call arguments') }
    let(:service) { instance_spy(described_class) }

    before { allow(described_class).to receive(:new).and_return(service) }

    it 'delegates the call to a new instance' do
      described_class.call(arguments)

      expect(service).to have_received(:call).with(arguments)
    end

    it 'also delegates the call if called with bang' do
      described_class.call!(arguments)

      expect(service).to have_received(:call!).with(arguments)
    end
  end

  describe '#call' do
    it 'raises a NotImplementedError' do
      expect { subject.call }.to raise_error(NotImplementedError)
    end
  end

  describe '#call!' do
    it 'raises a NotImplementedError' do
      expect { subject.call! }.to raise_error(NotImplementedError)
    end
  end
end
