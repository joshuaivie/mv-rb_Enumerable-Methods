require_relative '../enumerable'

RSpec.describe Enumerable do
  let(:array) {[1,2,3,4,5,6,7,8]}
  let(:range) {(1..10)}
  let(:hash) {{:my_name => "Zulfizar", :peer_name => "Joshua"}}
  describe '#my_each' do
    it 'returns enumerable if not block_given' do
      expect(array.my_each).to be_an Enumerator
    end
    it 'with nil' do
      expect { nil.my_each }.to raise_error(NoMethodError)
    end
    it 'for array' do
      expect(array.my_each {|n| n}).to eql(array.each {|n| n})
    end
    it 'for range' do
      expect(range.my_each {|n| n}).to eql(range.each {|n| n})
    end
    it 'for hash' do
      expect(range.my_each {|key, value| key}).to eql(range.each {|key, value| key})
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
      expect(array.my_each_with_index {|element, index| element}).to eql(array.each_with_index {|element, index| element})
    end
    it 'for range' do
      hash = Hash.new
      expect(range.my_each_with_index {|element, index| hash[element] = index}).to eql(range.each_with_index {|element, index| hash[element] = index})
    end
    it 'for hash' do
      expect(hash.my_each_with_index {|(key, value), index| index}).to eql(hash.each_with_index {|(key, value), index| index})
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
      expect(array.my_select {|element| element.even?}).to eql(array.select {|element| element.even?})
    end
    it 'for range' do
      expect(range.my_select {|element| element.even?}).to eql(range.select {|element| element.even?})
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
      expect(array.my_all? { |element| element.odd? }).to eql(array.all? {|element| element.odd?})
    end
    it 'block_given for range' do
      expect(range.my_all? { |element| element.odd? }).to eql(range.all? {|element| element.odd?})
    end
  end
end