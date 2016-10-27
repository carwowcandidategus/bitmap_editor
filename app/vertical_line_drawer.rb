# frozen_string_literal: true
require_relative './service'

class VerticalLineDrawer < Service
  def initialize(bitmap, args)
    @bitmap = bitmap

    a = args.split(' ')
    @column, @y1, @y2 = a[0..2].map(&:to_i).map { |i| i - 1 }
    @color = a[-1].to_s
  end

  def call
    (y1..y2).to_a.each do |y|
      bitmap[y][column] = color
    end
  end

  private

  attr_reader :bitmap, :column, :y1, :y2, :color
end
