# frozen_string_literal: true
require_relative './service'

class PixelColorService < Service
  COLOR_RANGE = ('A'..'Z').to_a.freeze # could use a regex

  def initialize(bitmap, args)
    @bitmap = bitmap

    a = args.split(' ')
    @w, @h = a[0..1].map(&:to_i).map { |i| i - 1 }
    @color = a[-1].to_s
  end

  def call
    with_valid_color { bitmap[h][w] = color }
  end

  private

  def valid?
    COLOR_RANGE.include?(color)
  end

  def with_valid_color
    if valid?
      yield
    else
      puts '`L X Y C` – C needs to be between A and Z'
    end
  end

  attr_reader :bitmap, :w, :h, :color
end
