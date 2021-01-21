require_relative '../ruby_enumerables'

describe Enumerable do
  let(:integer_array) { [1, 2, 3, 4, 5] }

  describe '#my_each' do
    it 'Is equal to the #each method' do
      expect(integer_array.my_each { |a| }).to eql(integer_array.each { |a| })
    end
    it "Doesn't change the original array" do
      expect(integer_array.my_each { |a| }).to eql(integer_array)
    end
    it 'Returns Enumerable when no block given' do
      expect(integer_array.my_each).to be_a Enumerator
    end
  end

  describe '#my_each_with_index' do
    let(:integer_array) { [1, 2, 3, 4, 5] }

    it 'Is equal to the #each_with_index method' do
      expect(integer_array.my_each_with_index { |a, i| a + i }).to eql(integer_array.each_with_index do |a, i|
                                                                         a + i
                                                                       end)
    end
    it "Doesn't change the original array" do
      expect(integer_array.my_each_with_index { |a, i| a + i }).to eql(integer_array)
    end
    it 'Returns Enumerable when no block given' do
      expect(integer_array.my_each_with_index).to be_a Enumerator
    end
  end

  describe '#my_select' do
    let(:integer_array) { [1, 2, 3, 4, 5] }
    let(:range) { (1..10) }

    it 'Is equal to the #select method when an array is given' do
      expect(integer_array.my_select(&:even?)).to eql(integer_array.select(&:even?))
    end
    it 'Is equal to the #select method when a range is given' do
      expect(range.my_select { |i| (i % 3).zero? }).to eql(range.select { |i| (i % 3).zero? })
    end
    it 'Returns Enumerable when no block given' do
      expect(integer_array.my_select).to be_a Enumerator
    end
  end

  describe '#my_all?' do
    it 'Returns true if all of the items pass a test given in a block' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(%w[ant bear cat].all? do |word|
                                                                            word.length >= 3
                                                                          end)
    end
    it 'Returns false if any of the items do not pass a test given in a block' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(%w[ant bear cat].all? do |word|
                                                                            word.length >= 4
                                                                          end)
    end
    it 'Returns true if all of the items match a Regex' do
      expect(%w[ant bat cat].my_all?(/t/)).to eql(%w[ant bat cat].all?(/t/))
    end
    it 'Returns false if any of the items do not match a Regex' do
      expect(%w[ant bear cat].my_all?(/b/)).to eql(%w[ant bear cat].all?(/b/))
    end
    it 'Returns true if all of the items are part of a class' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql([1, 2i, 3.14].all?(Numeric))
    end
    it 'Returns false if any of the items are not part of a class' do
      expect([1, 2i, 3.14].my_all?(Float)).to eql([1, 2i, 3.14].all?(Float))
    end
    it 'Returns true if all of the items match the argument' do
      expect(%w[cat cat cat].my_all?('cat')).to eql(%w[cat cat cat].all?('cat'))
    end
    it 'Returns false if any of the items do not match the argument' do
      expect(%w[ant bear cat].my_all?('cat')).to eql(%w[ant bear cat].all?('cat'))
    end
    it 'Returns true if all of the values are truthy' do
      expect(['cat', true, 99].my_all?).to eql(['cat', true, 99].all?)
    end
    it 'Returns false if any of the values are falsy' do
      expect([nil, true, 99].my_all?).to eql([nil, true, 99].all?)
    end
  end

  describe '#my_any?' do
    it 'Returns true if any of the items pass a test given in a block' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(%w[ant bear cat].any? do |word|
                                                                            word.length >= 3
                                                                          end)
    end
    it 'Returns false if none of the items pass a test given in a block' do
      expect(%w[ant bat cat].my_any? { |word| word.length >= 4 }).to eql(%w[ant bat cat].any? do |word|
                                                                           word.length >= 4
                                                                         end)
    end
    it 'Returns true if any of the items match a Regex' do
      expect(%w[ant bear cat].my_any?(/t/)).to eql(%w[ant bear cat].any?(/t/))
    end
    it 'Returns false if none of the items match a Regex' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(%w[ant bear cat].any?(/d/))
    end
    it 'Returns true if any of the items are part of a class' do
      expect([1, 2i, 3.14].my_any?(Float)).to eql([1, 2i, 3.14].any?(Float))
    end
    it 'Returns false if none of the items are part of a class' do
      expect([1, 2i, 3.14].my_any?(String)).to eql([1, 2i, 3.14].any?(String))
    end
    it 'Returns true if any of the items match the argument' do
      expect(%w[ant bear cat].my_any?('cat')).to eql(%w[ant bear cat].any?('cat'))
    end
    it 'Returns false if none of the items match the argument' do
      expect(%w[ant bear bat].my_any?('cat')).to eql(%w[ant bear bat].any?('cat'))
    end
    it 'Returns true if any of the values are truthy' do
      expect([nil, true, 99].my_any?).to eql([nil, true, 99].any?)
    end
    it 'Returns false if none of the values are truthy' do
      expect([nil, false, nil].my_any?).to eql([nil, false, nil].any?)
    end
  end

  describe '#my_none?' do
    it 'Returns true if none of the items pass a test given in a block' do
      expect(%w[ant bat cat].my_none? { |word| word.length >= 4 }).to eql(%w[ant bat cat].none? do |word|
                                                                            word.length >= 4
                                                                          end)
    end
    it 'Returns false if any of the items pass a test given in a block' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 3 }).to eql(%w[ant bear cat].none? do |word|
                                                                             word.length >= 3
                                                                           end)
    end
    it 'Returns true if none of the items match a Regex' do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(%w[ant bear cat].none?(/d/))
    end
    it 'Returns false if any of the items match a Regex' do
      expect(%w[ant bear cat].my_none?(/b/)).to eql(%w[ant bear cat].none?(/b/))
    end
    it 'Returns true if none of the items are part of a class' do
      expect([1, 2i, 3].my_none?(Float)).to eql([1, 2i, 3].none?(Float))
    end
    it 'Returns false if any of the items are part of a class' do
      expect([1, 2i, 3.14].my_none?(Float)).to eql([1, 2i, 3.14].none?(Float))
    end
    it 'Returns true if none of the items match the argument' do
      expect(%w[ant bear bat].my_none?('cat')).to eql(%w[ant bear bat].none?('cat'))
    end
    it 'Returns false if any of the items match the argument' do
      expect(%w[ant bear cat].my_none?('cat')).to eql(%w[ant bear cat].none?('cat'))
    end
    it 'Returns true if none of the values are truthy' do
      expect([nil, false, nil].my_none?).to eql([nil, false, nil].none?)
    end
    it 'Returns false if any of the values are truthy' do
      expect([nil, false, 99].my_none?).to eql([nil, false, 99].none?)
    end
  end

  describe '#my_count' do
    let(:integer_array2) { [1, 2, 4, 2] }

    it 'returns the number of items in the array if no argument and no block is passed.' do
      expect(integer_array2.my_count).to eql(integer_array2.count)
    end
    it 'returns the number of items that pass the test if a block is passed, but no argument is passed.' do
      expect(integer_array2.my_count(&:even?)).to eql(integer_array2.count(&:even?))
    end
    it 'returns the number of items equal to the argument if an argument is passed, but no block is passed.' do
      expect(integer_array2.my_count(2)).to eql(integer_array2.count(2))
    end
  end

  describe '#my_map' do
    let(:integer_array2) { [1, 2, 4, 2] }
    let(:range2) { (1..4) }

    it 'returns an Enumerator when no block nor proc are given' do
      expect(integer_array2.my_map).to be_a Enumerator
    end
    it 'returns an array when a block is given' do
      expect(range2.my_map { |i| i * i }).to eql(range2.map { |i| i * i })
    end
  end

  describe '#my_inject' do
    let(:range3) { (5..10) }

    it 'returns a single value based on the the application of a block' do
      expect(range3.my_inject { |sum, n| sum + n }).to eql(range3.my_inject { |sum, n| sum + n })
    end
    it 'returns a value when an initial value and a block is specified' do
      expect(range3.my_inject(1) { |product, n| product * n }).to eql(range3.inject(1) { |product, n| product * n })
    end
    it 'returns a value when a symbol and an initial value is specified' do
      expect(range3.my_inject(1, :*)).to eql(range3.my_inject(1, :*))
    end
    it 'returns a value when only a symbol is given' do
      expect(range3.my_inject(:+)).to eql(range3.inject(:+))
    end
  end
end
