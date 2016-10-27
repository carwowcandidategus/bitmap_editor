# frozen_string_literal: true
require_relative '../app/commands_executor'

describe CommandsExecutor do
  specify { expect { subject.call('bla') }.to output("unrecognised command :(\n").to_stdout }
end
