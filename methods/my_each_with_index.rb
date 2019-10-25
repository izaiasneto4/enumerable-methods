# frozen_string_literal: true

require_relative 'my_each'

module Enumerable
  def my_each_with_index
    if block_given?
      i = 0
      index = 0
      while i < size
        yield(index, at(i))
        index += 1
        i += 1
      end
    else
      'Error: my_each_with_index must have a block'
    end
  end
end
