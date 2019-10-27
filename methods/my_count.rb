# frozen_string_literal: true

require_relative 'my_each'

module Enumerable
  raise 'Error: The input for my_count must be an array' unless is_a?(Array)

  def my_count
    count = 0

    my_each do
      count += 1
    end

    count
  end
end

print "hello".my_count
