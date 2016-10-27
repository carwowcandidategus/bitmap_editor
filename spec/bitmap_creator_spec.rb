# frozen_string_literal: true
require_relative '../app/bitmap_creator'

describe BitmapCreator do
  describe '#call' do
    subject { described_class.new(args) }

    context 'with valid args' do
      let(:width) { 250 }
      let(:height) { 250 }
      let(:args) { "#{width} #{height}" }

      it 'returns an array' do
        returned_value = subject.call
        expect(returned_value.class).to eq(Array)
      end

      specify 'all positions return 0' do
        returned_value = subject.call

        (0...width).to_a.each do |i|
          (0...height).to_a.each do |j|
            expect(returned_value[i][j]).to eq(0)
          end
        end
      end
    end

    context 'with invalid args' do
      context 'both width and height less than 1' do
        let('args') { '0 0' }

        it 'prints a helper message' do
          expect { subject.call }
            .to output("`I M N` – M / N both need to be between 1 and 250\n").to_stdout
        end
      end

      context 'both width and height more than 250' do
        let('args') { '251 251' }

        it 'prints a helper message' do
          expect { subject.call }
            .to output("`I M N` – M / N both need to be between 1 and 250\n").to_stdout
        end
      end

      context 'with width less than 1' do
        let('args') { '0 1' }

        it 'prints a helper message' do
          expect { subject.call }
            .to output("`I M N` – M / N both need to be between 1 and 250\n").to_stdout
        end
      end

      context 'with height less than 1' do
        let('args') { '1 0' }

        it 'prints a helper message' do
          expect { subject.call }
            .to output("`I M N` – M / N both need to be between 1 and 250\n").to_stdout
        end
      end

      context 'with width more than 250' do
        let('args') { '251 1' }

        it 'prints a helper message' do
          expect { subject.call }
            .to output("`I M N` – M / N both need to be between 1 and 250\n").to_stdout
        end
      end

      context 'with height more than 250' do
        let('args') { '1 251' }

        it 'prints a helper message' do
          expect { subject.call }
            .to output("`I M N` – M / N both need to be between 1 and 250\n").to_stdout
        end
      end
    end
  end
end
