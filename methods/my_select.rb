# frozen_string_literal: true

require_relative 'my_each'

module Enumerable
  def my_select
    raise 'Error: No block was given' unless block_given?

    final_arr = []
    my_each do |i|
      final_arr.push(i) if yield(i)
    end

    final_arr
  end
end
