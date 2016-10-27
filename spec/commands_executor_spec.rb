# frozen_string_literal: true
require_relative '../app/commands_executor'

describe CommandsExecutor do
  specify { expect { subject.call('bla') }.to output("unrecognised command :(\n").to_stdout }

  describe '#call' do
    {
      'I M N'       => :create_bitmap,
      'C'           => :clear_bitmap,
      'L X Y C'     => :color_pixel,
      'V X Y1 Y2 C' => :draw_vertical_line,
      'H X1 X2 Y C' => :draw_horizontal_line,
      'S'           => :show_bitmap
    }.each do |input, expected_method_call|
      it 'calls the right method' do
        allow(subject).to receive(expected_method_call)
        subject.call(input)
        expect(subject).to have_received(expected_method_call)
      end
    end

    it 'exits gracefully if a StandardError is raised' do
      allow(subject).to receive(:clear_bitmap).and_raise(StandardError.new)
      expect { subject.call('C') }
        .to output("An error occured, please try again. Try `?` for help.\n").to_stdout
    end
  end

  describe '#create_bitmap' do
    let(:input) { '2 3' }

    it 'calls BitmapCreator' do
      allow(BitmapCreator).to receive(:call)
      subject.send(:create_bitmap, input)
      expect(BitmapCreator).to have_received(:call).with(input)
    end
  end

  describe '#color_pixel' do
    let(:input) { '2 3 C' }

    context 'with previously created bitmap' do
      let!(:bitmap) { subject.call('I 5 5') }

      it 'calls PixelColor' do
        allow(PixelColorService).to receive(:call)
        subject.send(:color_pixel, input)
        expect(PixelColorService).to have_received(:call).with(bitmap, input)
      end
    end

    context 'without a previously created bitmap' do
      it 'does not call PixelColor' do
        allow(PixelColorService).to receive(:call)
        expect { subject.send(:color_pixel, input) }
          .to output("No image created yet. Try `?` for help.\n").to_stdout
        expect(PixelColorService).to_not have_received(:call)
      end
    end
  end

  describe '#draw_vertical_line' do
    let(:input) { '2 3 6 W' }

    context 'with previously created bitmap' do
      let!(:bitmap) { subject.call('I 5 6') }

      it 'calls VerticalLineDrawer' do
        allow(VerticalLineDrawer).to receive(:call)
        subject.send(:draw_vertical_line, input)
        expect(VerticalLineDrawer).to have_received(:call).with(bitmap, input)
      end
    end

    context 'without a previously created bitmap' do
      it 'does not call PixelColor' do
        allow(VerticalLineDrawer).to receive(:call)
        expect { subject.send(:draw_vertical_line, input) }
          .to output("No image created yet. Try `?` for help.\n").to_stdout
        expect(VerticalLineDrawer).to_not have_received(:call)
      end
    end
  end
end
