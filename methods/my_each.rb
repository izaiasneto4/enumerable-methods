# frozen_string_literal: true

module Enumerable
  def my_each
    if block_given?
      i = 0
      while i < size
        yield at(i)
        i += 1
      end
    else
      'Error: my_each must have a block'
    end
  end
end
