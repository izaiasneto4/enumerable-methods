# frozen_string_literal: true

require_relative 'my_each'

module Enumerable
  def my_inject(arg_1 = nil, arg_2 = nil)
    array = to_a.dup
    (inject, sym, array) = get_inject_and_sym(arg_1, arg_2, array, block_given?)
    if sym
      inject = inject_sym(array, sym, inject)
    else
      array[0..-1].my_each { |i| inject = yield(inject, i) }
    end
    inject
  end

  def get_inject_and_sym(arg1, arg2, arr, block)
    inject_and_sym = if arg1.nil?
                       [arr.shift, nil, arr]
                     elsif arg2.nil? && !block
                       [arr.shift, arg1, arr]
                     elsif arg2.nil? && block
                       [arg1, nil, arr]
                     else
                       [arg1, arg2, arr]
                     end
    inject_and_sym
  end

  def inject_sym(array, sym, inject)
    array[0..-1].my_each { |i| inject = inject.send(sym, i) }
    inject
  end
end

def multiply_els
  array.my_inject { |mul, n| mul * n }
end
