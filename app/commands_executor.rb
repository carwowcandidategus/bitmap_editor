# frozen_string_literal: true
class CommandsExecutor
  UNRECOGNISED_COMMAND = -> (_) { puts 'unrecognised command :(' }

  def initialize
    @mappings = {}
  end

  def call(input)
    command, arguments = input.split(' ', 2)
    executor_for(command).call(arguments)
  end

  private

  def executor_for(command)
    mappings[command] || UNRECOGNISED_COMMAND
  end

  attr_reader :mappings
end
