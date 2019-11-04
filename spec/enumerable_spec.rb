# frozen_string_literal: true

require_relative '../main.rb'

RSpec.describe Enumerable do
  let (:test_arr) { [100, 54, 1, 2, 3, 4] }
  let (:test_arr2) { ['Billy', 'Wild Bill', 'Big Bill', 'Coffdrop'] }
  let (:test_arr3) { [12.2, 13.4, 15.5, 16.9, 10.2] }

  describe '#my_each' do
    context 'runs No block the same as #each' do
      it do
        expect(test_arr.my_each).to be_an(Enumerator)
      end
    end

    context 'runs a block the same as #each' do
      it do
        test = test_arr.each { |num| p num * 2 }
        expect(test_arr.my_each { |num| p num * 2 }).to eq(test)
      end
    end

    context 'runs a block the same as #each with array of strings' do
      it do
        test = test_arr2.each do |nickname, val|
          p "String: #{nickname}, Index: #{val}"
        end
        expect(test_arr2.my_each { |nickname, val| p "String: #{nickname}, Index: #{val}" }).to eq(test)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'runs No block the same as #each_with_index' do
      it do
        expect(test_arr.my_each_with_index).to be_an(Enumerator)
      end
    end
    context 'is identical to #each_with_index' do
      it do
        test = test_arr.each_with_index { |num, i| p num + i }
        expect(test_arr.my_each_with_index { |num, i| p num + i }).to eq(test)
      end
    end
  end

  describe '#my_all' do
    context 'runs No block the same as #all' do
      it do
        expect(test_arr.my_all?).to eq(true)
      end
    end
    context 'is identical to #all with Integers' do
      it do
        test = test_arr.all? { |num| num.is_a? Integer }
        expect(test_arr.my_all? { |num| num.is_a? Integer }).to eq(test)
      end
    end
    context 'is identical to #all with Strings' do
      it do
        test = test_arr.all? { |num| num.is_a? String }
        expect(test_arr.my_all? { |num| num.is_a? String }).to eq(test)
      end
    end
    context 'is identical to #all with Strings 2' do
      it do
        test = test_arr2.all? { |name| name[0] == 'B' }
        expect(test_arr2.my_all? { |name| name[0] == 'B' }).to eq(test)
      end
    end
  end

  describe '#my_any' do
    context 'runs No block the same as #any' do
      it do
        expect(test_arr.my_any?).to eq(true)
      end
    end
    context 'is identical to #any with Integers' do
      it do
        test = test_arr.any? { |num| num.is_a? Integer }
        expect(test_arr.my_any? { |num| num.is_a? Integer }).to eq(test)
      end
    end

    context 'is identical to #any with Strings' do
      it do
        test = test_arr.any? { |num| num.is_a? String }
        expect(test_arr.my_any? { |num| num.is_a? String }).to eq(test)
      end
    end

    context 'is identical to #any with Strings 2' do
      it do
        test = test_arr2.any? { |name| name.match(/Bi/) }
        expect(test_arr2.my_any? { |name| name.match(/Bi/) }).to eq(test)
      end
    end

    context 'is identical to #any using String parameter' do
      it do
        expect(test_arr2.my_any?('Billy')).to eq(true)
      end
    end
  end

  describe '#my_count' do
    context 'runs No block the same as #count' do
      it do
        expect(test_arr.my_count).to eq(6)
      end
    end
    context 'is identical to #count using parameter' do
      it do
        expect(test_arr.my_count(1)).to eq(1)
      end
    end
    context 'is identical to #count using no parameter' do
      it do
        expect(test_arr.my_count).to eq(6)
      end
    end
    context 'is identical to #count using block' do
      it do
        expect(test_arr.my_count { |num| num < 4 }).to eq(3)
      end
    end
  end

  describe '#none' do
    context 'runs No block the same as #none' do
      it do
        expect(test_arr.my_none?).to eq(false)
      end
    end
    context 'is identical to #none with Integers' do
      it do
        test = test_arr.none? { |num| num.is_a? Integer }
        expect(test_arr.my_none? { |num| num.is_a? Integer }).to eq(test)
      end
    end

    context 'is identical to #none with Strings' do
      it do
        test = test_arr.none? { |num| num.is_a? String }
        expect(test_arr.my_none? { |num| num.is_a? String }).to eq(test)
      end
    end

    context 'is identical to #none with Strings 2' do
      it do
        test = test_arr2.none? { |name| name.match(/zzz/) }
        expect(test_arr2.my_none? { |name| name.match(/zzz/) }).to eq(test)
      end
    end

    context 'is identical to #none using Integer parameter' do
      it do
        expect(test_arr.my_none?(3)).to eq(false)
      end
    end

    context 'is identical to #count using String parameter' do
      it do
        expect(test_arr2.my_none?('Billy')).to eq(false)
      end
    end
  end

  describe '#select' do
    context 'runs No block the same as #select' do
      it do
        expect(test_arr.my_select).to be_an(Enumerator)
      end
    end
    context 'is identical to #select' do
      it do
        test = test_arr.select(&:even?)
        expect(test_arr.my_select(&:even?)).to eq(test)
      end
    end

    context 'is identical to #select 2' do
      it do
        test = test_arr3.select do |num|
          num.to_f > 13.3
        end
        expect(test_arr3.my_select { |num| num.to_f > 13.3 }).to eq(test)
      end
    end
  end

  describe '#map' do
    context 'runs No block the same as #map' do
      it do
        expect(test_arr.my_map).to be_an(Enumerator)
      end
    end
    context 'is identical to #map' do
      it do
        test = test_arr.map { |num| num * 10 }
        expect(test_arr.my_map { |num| num * 10 }).to eq(test)
      end
    end

    context 'takes either a proc or a block' do
      it do
        test_block = proc { |elem| elem * 10 }
        test = test_arr.map(&test_block)
        expect(test_arr.my_map(&test_block)).to eq(test)
      end
    end
  end

  describe '#inject' do
    context 'is identical to #inject' do
      it do
        test = test_arr.inject { |result, elem| result + elem }
        expect(test_arr.my_inject { |result, elem| result + elem }).to eq(test)
      end
    end
  end
end
