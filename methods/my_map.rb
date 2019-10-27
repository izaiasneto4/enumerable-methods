# frozen_string_literal: true

require_relative 'my_each'

module Enumerable
  def my_map
    final_arr = []

    my_each do |i|
      final_arr.push(yield(i))
    end

    final_arr
  end
end
