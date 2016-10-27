# frozen_string_literal: true
require_relative './service'

class BitmapCreator < Service
  COORDINATES_RANGE = (1..250).to_a.freeze

  def initialize(args)
    @width, @height = args.split(' ').map(&:to_i)
  end

  def call
    with_valid_coordinates { Array.new(height) { Array.new(width) { 0 } } }
  end

  private

  def valid?
    COORDINATES_RANGE.include?(width) && COORDINATES_RANGE.include?(height)
  end

  def with_valid_coordinates
    if valid?
      yield
    else
      puts '`I M N` – M / N both need to be between 1 and 250'
    end
  end

  attr_reader :width, :height
end
