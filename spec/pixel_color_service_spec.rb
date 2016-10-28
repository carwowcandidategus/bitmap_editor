# frozen_string_literal: true
require_relative '../app/pixel_color_service'
require_relative '../app/commands_executor'

describe PixelColorService do
  let!(:bitmap) { CommandsExecutor.new.call('I 5 5') }
  let(:w) { 2 }
  let(:h) { 3 }
  let(:c) { 'A' }
  let(:args) { "#{w} #{h} #{c}" }

  describe '#call' do
    subject { described_class.new(bitmap, args) }

    context 'with valid args' do
      it 'colors the pixel' do
        expect { subject.call }.to change { bitmap[h - 1][w - 1] }.from(0).to(c)
      end
    end

    context 'with invalid args' do
      let(:c) { 1 }

      context 'with invalid color' do
        it 'prints a helper message' do
          expect { subject.call }
            .to output("`L X Y C` – C needs to be between A and Z\n").to_stdout
        end
      end
    end
  end
end
