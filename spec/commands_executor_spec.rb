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
  end
end
