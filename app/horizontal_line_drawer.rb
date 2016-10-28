# frozen_string_literal: true
require_relative './service'

class HorizontalLineDrawer < Service
  def initialize(bitmap, args)
    @bitmap = bitmap

    a = args.split(' ')
    @x1, @x2, @row = a[0..2].map(&:to_i)
    @color = a[-1].to_s
  end

  def call
    @x1, @x2 = x2, x1 if x1 > x2
    (x1..x2).to_a.each do |x|
      PixelColorService.call(bitmap, "#{x} #{row} #{color}")
    end
  end

  private

  attr_reader :bitmap, :row, :x1, :x2, :color
end
