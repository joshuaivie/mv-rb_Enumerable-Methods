require_relative '../enumerable'

RSpec.describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5, 6, 7, 8] }
  let(:string_array) { %w[apple ball call dog elephant] }
  let(:range) { (1..10) }
  let(:hash) { { my_name: 'Zulfizar', peer_name: 'Joshua' } }
  describe '#my_each' do
    it 'returns enumerable if not block_given' do
      expect(array.my_each).to be_an Enumerator
    end
    it 'with nil' do
      expect { nil.my_each }.to raise_error(NoMethodError)
    end
    it 'for array' do
      expect(array.my_each { |n| n }).to eql(array.each { |n| n })
    end
    it 'for range' do
      expect(range.my_each { |n| n }).to eql(range.each { |n| n })
    end
    it 'for hash' do
      expect(range.my_each { |key, _value| key }).to eql(range.each { |key, _value| key })
    end
  end

  describe '#my_each_with_index' do
    it 'returns enumerable if not block_given' do
      expect(array.my_each_with_index).to be_an Enumerator
    end
    it 'with nil' do
      expect { nil.my_each_with_index }.to raise_error(NoMethodError)
    end
    it 'for array' do
      expect(array.my_each_with_index { |element, _index| element }).to eql(array.each_with_index { |element, _index| element })
    end
    it 'for range' do
      hash = {}
      expect(range.my_each_with_index { |element, index| hash[element] = index }).to eql(range.each_with_index { |element, index| hash[element] = index })
    end
    it 'for hash' do
      expect(hash.my_each_with_index { |(_key, _value), index| index }).to eql(hash.each_with_index { |(_key, _value), index| index })
    end
  end

  describe '#my_selct' do
    it 'returns enumerable if not block_given' do
      expect(array.my_select).to be_an Enumerator
    end
    it 'with nil' do
      expect { nil.my_select }.to raise_error(NoMethodError)
    end
    it 'for array' do
      expect(array.my_select(&:even?)).to eql(array.select(&:even?))
    end
    it 'for range' do
      expect(range.my_select(&:even?)).to eql(range.select(&:even?))
    end
    it 'it returns the selected element from a array of symbols' do
      my_result = %i[foo bar].my_select { |x| x == :foo }
      std_result = %i[foo bar].select { |x| x == :foo }
      expect(my_result).to eql(std_result)
    end
  end

  describe '#my_all?' do
    it 'no block_given for array' do
      expect(array.my_all?).to eql(array.all?)
    end
    it 'no block_given for range' do
      expect(range.my_all?).to eql(range.all?)
    end
    it 'no block_given for hash' do
      expect(hash.my_all?).to eql(hash.all?)
    end
    it 'raises error if given nil' do
      expect { nil.may_all? }.to raise_error(NoMethodError)
    end
    it 'block_given for array' do
      expect(array.my_all? { |element| element == 1 }).to eql(array.all? { |element| element == 2 })
    end
    it 'block_given for range' do
      expect(range.my_all? { |element| element == 2 }).to eql(range.all? { |element| element == 2 })
    end
    it 'test with class given' do
      expect(array.my_all?(Integer)).to eql(array.all?(Integer))
    end
    it 'test with regex given' do
      expect(string_array.my_all?(/[a-z]/)).to eql(string_array.all?(/[a-z]/))
    end
  end

  describe '#my_any?' do
    it 'no block_given for array' do
      expect(array.my_any?).to eql(array.any?)
    end
    it 'no block_given for range' do
      expect(range.my_any?).to eql(range.any?)
    end
    it 'no block_given for hash' do
      expect(hash.my_any?).to eql(hash.any?)
    end
    it 'raises error if given nil' do
      expect { nil.may_any? }.to raise_error(NoMethodError)
    end
    it 'block_given for array' do
      expect(array.my_any? { |element| element == 2 }).to eql(array.any? { |element| element == 2 })
    end
    it 'block_given for range' do
      expect(range.my_any? { |element| element == 2 }).to eql(range.any? { |element| element == 2 })
    end
    it 'tests with class given' do
      expect(array.my_any?(Integer)).to eql(array.any?(Integer))
    end
    it 'tests with regex given' do
      expect(string_array.my_any?(/[1-9]/)).to eql(string_array.any?(/[1-9]/))
    end
  end

  describe '#my_none?' do
    it 'no block_given for array' do
      expect(array.my_none?).to eql(array.none?)
    end
    it 'no block_given for range' do
      expect(range.my_none?).to eql(range.none?)
    end
    it 'no block_given for hash' do
      expect(hash.my_none?).to eql(hash.none?)
    end
    it 'raises error if given nil' do
      expect { nil.may_none? }.to raise_error(NoMethodError)
    end
    it 'block_given for array' do
      expect(array.my_none? { |element| element == 100 }).to eql(array.none? { |element| element == 100 })
    end
    it 'block_given for range' do
      expect(range.my_none? { |element| element == 100 }).to eql(range.none? { |element| element == 100 })
    end
    it 'tests with class given' do
      expect(array.my_none?(String)).to eql(array.none?(String))
    end
    it 'testd with regex given' do
      expect(string_array.my_none?(/[a-z]/)).to eql(string_array.none?(/[a-z]/))
    end
  end

  describe '#my_count?' do
    it 'no block_given for array' do
      expect(array.my_count).to eql(array.count)
    end
    it 'no block_given for range' do
      expect(range.my_count).to eql(range.count)
    end
    it 'no block_given for hash' do
      expect(hash.my_count).to eql(hash.count)
    end
    it 'raises error if given nil' do
      expect { nil.may_count }.to raise_error(NoMethodError)
    end
    it 'block_given for array' do
      expect(array.my_count(&:even?)).to eql(array.count(&:even?))
    end
    it 'block_given for range' do
      expect(range.my_count(&:even?)).to eql(range.count(&:even?))
    end
    it 'counts length when no test param given' do
      expect(array.my_count).to eql(array.count)
    end
  end
end
