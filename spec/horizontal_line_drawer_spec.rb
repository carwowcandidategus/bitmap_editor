# frozen_string_literal: true
require_relative '../app/horizontal_line_drawer'
require_relative '../app/commands_executor'

describe HorizontalLineDrawer do
  let!(:bitmap) { CommandsExecutor.new.call('I 5 6') }
  let(:row) { 3 }
  let(:x1) { 5 }
  let(:x2) { 2 }
  let(:c) { 'Z' }
  let(:args) { "#{x1} #{x2} #{row} #{c}" }

  describe '#call' do
    subject { described_class.new(bitmap, args) }

    it 'colors the required pixels' do
      subject.call
      (x1..x2).to_a.each { |x| expect(bitmap[row - 1][x - 1]).to eq(c) }
    end
  end
end
