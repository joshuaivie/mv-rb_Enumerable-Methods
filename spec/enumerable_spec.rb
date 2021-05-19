require_relative '../enumerable'

RSpec.describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5, 6, 7, 8] }
  let(:string_array) { %w[apple ball call dog elephant] }
  let(:range) { (1..10) }
  let(:hash) { { my_name: 'Zulfizar', peer_name: 'Joshua' } }

  describe '#my_each' do
    it 'returns enumerable if no block_given' do
      expect(array.my_each).to be_an Enumerator
    end
    it 'raises NoMethod error when applied on nil' do
      expect { nil.my_each }.to raise_error(NoMethodError)
    end
    it 'returns each element from a supplied array' do
      expect(array.my_each { |n| n }).to eql(array.each { |n| n })
    end
    it 'returns each element from a supplied range' do
      expect(range.my_each { |n| n }).to eql(range.each { |n| n })
    end
    it 'returns each element from a supplied hash' do
      expect(range.my_each { |key, _value| key }).to eql(range.each { |key, _value| key })
    end
  end

  describe '#my_each_with_index' do
    it 'returns enumerable if no block_given' do
      expect(array.my_each_with_index).to be_an Enumerator
    end
    it 'raises NoMethod error when applied on nil' do
      expect { nil.my_each_with_index }.to raise_error(NoMethodError)
    end
    it 'returns each element and index from a supplied array' do
      expect(array.my_each_with_index { |element, _index| element }).to eql(array.each_with_index { |element, _index| element })
    end
    it 'returns each element and index from a supplied array' do
      hash = {}
      expect(range.my_each_with_index { |element, index| hash[element] = index }).to eql(range.each_with_index { |element, index| hash[element] = index })
    end
    it 'returns each element and index from a supplied array' do
      expect(hash.my_each_with_index { |(_key, _value), index| index }).to eql(hash.each_with_index { |(_key, _value), index| index })
    end
  end

  describe '#my_select' do
    it 'returns enumerable if no block_given' do
      expect(array.my_select).to be_an Enumerator
    end
    it 'raises NoMethod error when applied on nil' do
      expect { nil.my_select }.to raise_error(NoMethodError)
    end
    it 'returns the selected element from an array' do
      expect(array.my_select(&:even?)).to eql(array.select(&:even?))
    end
    it 'returns the selected element from a range' do
      expect(range.my_select(&:even?)).to eql(range.select(&:even?))
    end
    it 'returns the selected element from an array of symbols' do
      my_result = %i[foo bar].my_select { |x| x == :foo }
      std_result = %i[foo bar].select { |x| x == :foo }
      expect(my_result).to eql(std_result)
    end
  end

  describe '#my_all?' do
    it 'returns true if no block_given for array' do
      expect(array.my_all?).to eql(array.all?)
    end
    it 'returns true if no block_given for range' do
      expect(range.my_all?).to eql(range.all?)
    end
    it 'returns true if no block_given for hash' do
      expect(hash.my_all?).to eql(hash.all?)
    end
    it 'raises NoMethod error when applied on nil' do
      expect { nil.may_all? }.to raise_error(NoMethodError)
    end
    it 'returns true if block never returns false or nil for array elements' do
      expect(array.my_all? { |element| element == 1 }).to eql(array.all? { |element| element == 2 })
    end
    it 'returns true if block never returns false or nil for range members' do
      expect(range.my_all? { |element| element == 2 }).to eql(range.all? { |element| element == 2 })
    end
    it 'returns true if all array elements are of Class type' do
      expect(array.my_all?(Integer)).to eql(array.all?(Integer))
    end
    it 'returns true if all array elements match regular expression' do
      expect(string_array.my_all?(/[a-z]/)).to eql(string_array.all?(/[a-z]/))
    end
  end

  describe '#my_any?' do
    it 'returns true for non-empty array' do
      expect(array.my_any?).to eql(array.any?)
    end
    it 'returns true if non zero range' do
      expect(range.my_any?).to eql(range.any?)
    end
    it 'returns true for non-empty hash' do
      expect(hash.my_any?).to eql(hash.any?)
    end
    it 'raises NoMethod error when applied on nil' do
      expect { nil.may_any? }.to raise_error(NoMethodError)
    end
    it 'returns true if block returns true for any array elements' do
      expect(array.my_any? { |element| element == 2 }).to eql(array.any? { |element| element == 2 })
    end
    it 'returns true if block returns true for any range members' do
      expect(range.my_any? { |element| element == 2 }).to eql(range.any? { |element| element == 2 })
    end
    it 'returns true if any array elements are of Class type' do
      expect(array.my_any?(Integer)).to eql(array.any?(Integer))
    end
    it 'returns true if any array elements match regular expression' do
      expect(string_array.my_any?(/[1-9]/)).to eql(string_array.any?(/[1-9]/))
    end
  end

  describe '#my_none?' do
    it 'returns true for empty array' do
      expect(array.my_none?).to eql(array.none?)
    end
    it 'returns true for empty range' do
      expect(range.my_none?).to eql(range.none?)
    end
    it 'returns true for empty hash' do
      expect(hash.my_none?).to eql(hash.none?)
    end
    it 'raises NoMethod error when applied on nil' do
      expect { nil.may_none? }.to raise_error(NoMethodError)
    end
    it 'returns true if block always return false or nil for any array elements' do
      expect(array.my_none? { |element| element == 100 }).to eql(array.none? { |element| element == 100 })
    end
    it 'returns true if block always return false or nil for any range members' do
      expect(range.my_none? { |element| element == 100 }).to eql(range.none? { |element| element == 100 })
    end
    it 'returns true if no array elements are of Class type' do
      expect(array.my_none?(String)).to eql(array.none?(String))
    end
    it 'returns true if no array elements are of Class type' do
      expect(string_array.my_none?(/[a-z]/)).to eql(string_array.none?(/[a-z]/))
    end
  end

  describe '#my_count?' do
    it 'returns length of array when no block given' do
      expect(array.my_count).to eql(array.count)
    end
    it 'returns length of range when no block given' do
      expect(range.my_count).to eql(range.count)
    end
    it 'returns size of hash when no block given' do
      expect(hash.my_count).to eql(hash.count)
    end
    it 'raises NoMethodError error if called on nil' do
      expect { nil.may_count }.to raise_error(NoMethodError)
    end
    it 'returns count of array elements yielding a true value to block' do
      expect(array.my_count(&:even?)).to eql(array.count(&:even?))
    end
    it 'returns count of range elements yielding a true value to block' do
      expect(range.my_count(&:even?)).to eql(range.count(&:even?))
    end
  end

  describe '#my_map' do
    it 'returns enumerable if no block_given' do
      expect(array.my_map).to be_an Enumerator
    end
    it 'raises NoMethodError when called on nil' do
      expect { nil.my_map }.to raise_error(NoMethodError)
    end
    it 'return map array result for input array' do
      expect(array.my_map { |element| element + 2 }).to eql(array.map { |element| element + 2 })
    end
    it 'returns may array result for input range' do
      expect(range.my_map { |element| element * 2 }).to eql(range.map { |element| element * 2 })
    end
  end

  describe '#my_inject' do
    it 'returns result when both operator and initial are given' do
      expect(array.my_inject(1, :*)).to eql(array.inject(1, :*))
    end
    it 'returns result when only operator is given' do
      expect(array.my_inject(:*)).to eql(array.inject(:*))
    end
    it 'returns result when initial and block are given' do
      my_result = array.my_inject(100) { |initial, element| initial + element }
      standard_result = array.inject(100) { |initial, element| initial + element }
      expect(my_result).to eql(standard_result)
    end
    it 'returns result when only block is given' do
      my_result = array.my_inject { |initial, element| initial * element }
      standard_result = array.inject { |initial, element| initial * element }
      expect(my_result).to eql(standard_result)
    end
    it 'returns result when range given too' do
      expect(range.my_inject(:*)).to eql(range.inject(:*))
    end
    it 'raises a Local Jump error when no block given' do
      expect { array.my_inject }.to raise_error(LocalJumpError)
    end
  end

  describe '#multiply_els' do
    it 'returns result when all elements in an array are multiplied' do
      expect(multiply_els([2, 2, 2, 2])).to eql(16)
    end
    it 'raises an Argument error when no parameter given' do
      expect { multiply_els }.to raise_error(ArgumentError)
    end
  end
end
