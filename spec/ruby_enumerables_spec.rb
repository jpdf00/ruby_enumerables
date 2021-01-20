require_relative '../ruby_enumerables'

describe Enumerable do
  describe '#my_each' do
    it 'Is equal to the #each method' do
      expect([1,2,3,4,5].my_each { |a| a }).to eql([1,2,3,4,5].each { |a| a })
    end
    it "Doesn't change the original array" do
      expect([1,2,3,4,5].my_each { |a| a }).to eql([1,2,3,4,5])
    end
    it "Returns Enumerable when no block given" do
      expect([1,2,3,4,5].my_each).to be_a Enumerator
    end
  end

  describe '#my_each_with_index' do
    it 'Is equal to the #each_with_index method' do
      expect([1,2,3,4,5].my_each_with_index { |a, i| a + i }).to eql([1,2,3,4,5].each_with_index { |a, i| a + i })
    end
    it "Doesn't change the original array" do
      expect([1,2,3,4,5].my_each_with_index { |a, i| a + i }).to eql([1,2,3,4,5])
    end
    it "Returns Enumerable when no block given" do
      expect([1,2,3,4,5].my_each_with_index).to be_a Enumerator
    end
  end

  describe '#my_select' do
    it 'Is equal to the #select method when an array is given' do
      expect([1,2,3,4,5].my_select { |num|  num.even?  }).to eql([1,2,3,4,5].select { |num|  num.even?  })
    end
    it 'Is equal to the #select method when a range is given' do
      expect((1..10).my_select { |i|  i % 3 == 0 }).to eql((1..10).select { |i|  i % 3 == 0 })
    end
    it "Returns Enumerable when no block given" do
      expect([1,2,3,4,5].my_select).to be_a Enumerator
    end
  end

  describe '#my_all?' do
    it 'Returns true if all of the items pass a test given in a block' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3}).to eql(%w[ant bear cat].all? { |word| word.length >= 3 })
    end
    it 'Returns false if any of the items do not pass a test given in a block' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(%w[ant bear cat].all? { |word| word.length >= 4 })
    end
    it "Returns true if all of the items match a Regex" do
      expect(%w[ant bat cat].my_all?(/t/)).to eql(%w[ant bat cat].all?(/t/))
    end
    it 'Returns false if any of the items do not match a Regex' do
      expect(%w[ant bear cat].my_all?(/b/)).to eql(%w[ant bear cat].all?(/b/))
    end
    it "Returns true if all of the items are part of a class" do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql([1, 2i, 3.14].all?(Numeric))
    end
    it 'Returns false if any of the items are not part of a class' do
      expect([1, 2i, 3.14].my_all?(Float)).to eql([1, 2i, 3.14].all?(Float))
    end
    it "Returns true if all of the items match the argument" do
      expect(%w[cat cat cat].my_all?("cat")).to eql(%w[cat cat cat].all?("cat"))
    end
    it 'Returns false if any of the items do not match the argument' do
      expect(%w[ant bear cat].my_all?("cat")).to eql(%w[ant bear cat].all?("cat"))
    end
    it "Returns true if all of the values are truthy" do
      expect(["cat", true, 99].my_all?).to eql(["cat", true, 99].all?)
    end
    it 'Returns false if any of the values are falsy' do
      expect([nil, true, 99].my_all?).to eql([nil, true, 99].all?)
    end
  end

  describe '#my_any?' do
    it 'Returns true if any of the items pass a test given in a block' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3}).to eql(%w[ant bear cat].any? { |word| word.length >= 3 })
    end
    it 'Returns false if none of the items pass a test given in a block' do
      expect(%w[ant bat cat].my_any? { |word| word.length >= 4 }).to eql(%w[ant bat cat].any? { |word| word.length >= 4 })
    end
    it "Returns true if any of the items match a Regex" do
      expect(%w[ant bear cat].my_any?(/t/)).to eql(%w[ant bear cat].any?(/t/))
    end
    it 'Returns false if none of the items match a Regex' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(%w[ant bear cat].any?(/d/))
    end
    it "Returns true if any of the items are part of a class" do
      expect([1, 2i, 3.14].my_any?(Float)).to eql([1, 2i, 3.14].any?(Float))
    end
    it 'Returns false if none of the items are part of a class' do
      expect([1, 2i, 3.14].my_any?(String)).to eql([1, 2i, 3.14].any?(String))
    end
    it "Returns true if any of the items match the argument" do
      expect(%w[ant bear cat].my_any?("cat")).to eql(%w[ant bear cat].any?("cat"))
    end
    it 'Returns false if none of the items match the argument' do
      expect(%w[ant bear bat].my_any?("cat")).to eql(%w[ant bear bat].any?("cat"))
    end
    it "Returns true if any of the values are truthy" do
      expect([nil, true, 99].my_any?).to eql([nil, true, 99].any?)
    end
    it 'Returns false if none of the values are truthy' do
      expect([nil, false, nil].my_any?).to eql([nil, false, nil].any?)
    end
  end

  describe '#my_none?' do
    it 'Returns true if none of the items pass a test given in a block' do
      expect(%w[ant bat cat].my_none? { |word| word.length >= 4}).to eql(%w[ant bat cat].none? { |word| word.length >= 4 })
    end
    it 'Returns false if any of the items pass a test given in a block' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 3 }).to eql(%w[ant bear cat].none? { |word| word.length >= 3 })
    end
    it "Returns true if none of the items match a Regex" do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(%w[ant bear cat].none?(/d/))
    end
    it 'Returns false if any of the items match a Regex' do
      expect(%w[ant bear cat].my_none?(/b/)).to eql(%w[ant bear cat].none?(/b/))
    end
    it "Returns true if none of the items are part of a class" do
      expect([1, 2i, 3].my_none?(Float)).to eql([1, 2i, 3].none?(Float))
    end
    it 'Returns false if any of the items are part of a class' do
      expect([1, 2i, 3.14].my_none?(Float)).to eql([1, 2i, 3.14].none?(Float))
    end
    it "Returns true if none of the items match the argument" do
      expect(%w[ant bear bat].my_none?("cat")).to eql(%w[ant bear bat].none?("cat"))
    end
    it 'Returns false if any of the items match the argument' do
      expect(%w[ant bear cat].my_none?("cat")).to eql(%w[ant bear cat].none?("cat"))
    end
    it "Returns true if none of the values are truthy" do
      expect([nil, false, nil].my_none?).to eql([nil, false, nil].none?)
    end
    it 'Returns false if any of the values are truthy' do
      expect([nil, false, 99].my_none?).to eql([nil, false, 99].none?)
    end
  end

  describe '#my_count' do
    it 'returns the number of items in the array if no argument and no block is passed.' do
      expect([1, 2, 4, 2].my_count).to eql([1, 2, 4, 2].count)
    end
    it 'returns the number of items that pass the test if a block is passed, but no argument is passed.' do
      expect([1, 2, 4, 2].my_count{ |x| x%2==0 }).to eql([1, 2, 4, 2].count{ |x| x%2==0 })
    end
    it 'returns the number of items equal to the argument if an argument is passed, but no block is passed.' do
      expect([1, 2, 4, 2].my_count(2)).to eql([1, 2, 4, 2].count(2))
    end
  end

  describe '#my_map' do
    it 'returns an Enumerator when no block nor proc are given' do
      expect([1, 2, 4, 2].my_map).to be_a Enumerator
    end
    it 'returns an array when a block is given' do
      expect((1..4).my_map { |i| i*i }).to eql((1..4).map { |i| i*i })
    end
  end

  describe '#my_inject' do
    it 'returns a single value based on the the application of a block' do
      expect((5..10).my_inject { |sum, n| sum + n } ).to eql((5..10).my_inject { |sum, n| sum + n } )
    end
    it 'returns a value when an initial value and a block is specified' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eql((5..10).inject(1) { |product, n| product * n })
    end
    it 'returns a value when a symbol and an initial value is specified' do
      expect((5..10).my_inject(1, :*)).to eql((5..10).my_inject(1, :*))
    end
    it 'returns a value when only a symbol is given' do
      expect((5..10).my_inject(:+)).to eql((5..10).inject(:+))
    end
  end
end
