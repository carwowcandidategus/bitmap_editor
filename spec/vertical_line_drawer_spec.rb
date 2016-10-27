# frozen_string_literal: true
require_relative '../app/vertical_line_drawer'

describe VerticalLineDrawer do
  let!(:bitmap) { CommandsExecutor.new.call('I 5 6') }
  let(:column) { 2 }
  let(:y1) { 3 }
  let(:y2) { 6 }
  let(:c) { 'W' }
  let(:args) { "#{column} #{y1} #{y2} #{c}" }

  describe '#call' do
    subject { described_class.new(bitmap, args) }

    it 'colors the required pixels' do
      subject.call
      (y1..y2).to_a.each { |y| expect(bitmap[y - 1][column - 1]).to eq(c) }
    end
  end
end
