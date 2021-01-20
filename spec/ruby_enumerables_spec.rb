require './ruby_enumerables'

describe Enumerable do
  describe '#my_each' do
    it 'Is equal to the #each method' do
      expect([1,2,3,4,5].my_each { |a| a }).to eql([1,2,3,4,5].each { |a| a })
    end
    it "Doesn't change the original array" do
      expect([1,2,3,4,5].my_each { |a| a }).to eql([1,2,3,4,5])
    end
    #it "Returns Enumerable when no block given" do
      #expect(integer_array.my_each).to eql(integer_array.to_enum)
    #end
  end

  describe '#my_each_with_index' do
    it 'Is equal to the #each_with_index method' do
      expect([1,2,3,4,5].my_each_with_index { |a, i| a + i }).to eql([1,2,3,4,5].each_with_index { |a, i| a + i })
    end
    it "Doesn't change the original array" do
      expect([1,2,3,4,5].my_each_with_index { |a, i| a + i }).to eql([1,2,3,4,5])
    end
    #it "Returns Enumerable when no block given" do
      #expect(integer_array.my_each_with_index).to eql(integer_array.to_enum)
    #end
  end

  describe '#my_select' do
    it 'Is equal to the #select method' do
      expect([1,2,3,4,5].my_select { |num|  num.even?  }).to eql([1,2,3,4,5].select { |num|  num.even?  })
      expect((1..10).my_select { |i|  i % 3 == 0 }).to eql((1..10).select { |i|  i % 3 == 0 })
      expect([:foo, :bar].my_select { |x| x == :foo }).to eql([:foo, :bar].select { |x| x == :foo })
    end
    #it "Returns Enumerable when no block given" do
      #expect(integer_array.my_each_with_index).to eql(integer_array.to_enum)
    #end
  end

  describe '#my_all?' do
    it 'Returns true when all of the items pass a test given in a block' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3}).to eql(%w[ant bear cat].all? { |word| word.length >= 3 })
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(%w[ant bear cat].all? { |word| word.length >= 4 })
    end
    it "Returns true if all of the items match a Regex" do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(%w[ant bear cat].all?(/t/))
      expect(%w[ant bear cat].my_all?(/b/)).to eql(%w[ant bear cat].all?(/b/))
    end
    it "Returns true if all of the items are part of a class" do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql([1, 2i, 3.14].all?(Numeric))
      expect([1, 2i, 3.14].my_all?(Float)).to eql([1, 2i, 3.14].all?(Float))
    end
    it "Returns true if all of the items match the argument" do
      expect(%w[cat cat cat].my_all?("cat")).to eql(%w[cat cat cat].all?("cat"))
      expect(%w[ant bear cat].my_all?("cat")).to eql(%w[ant bear cat].all?("cat"))
    end
    it "Returns true if all of the values are truthy" do
      expect(["cat", true, 99].my_all?).to eql(["cat", true, 99].all?)
      expect([nil, true, 99].my_all?).to eql([nil, true, 99].all?)
    end
  end

  describe '#my_any?' do
    it 'Returns true when any of the items pass a test given in a block' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3}).to eql(%w[ant bear cat].any? { |word| word.length >= 3 })
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql(%w[ant bear cat].any? { |word| word.length >= 4 })
    end
    it "Returns true if any of the items match a Regex" do
      expect(%w[ant bear cat].my_any?(/t/)).to eql(%w[ant bear cat].any?(/t/))
      expect(%w[ant bear cat].my_any?(/b/)).to eql(%w[ant bear cat].any?(/b/))
    end
    it "Returns true if any of the items are part of a class" do
      expect([1, 2i, 3.14].my_any?(Numeric)).to eql([1, 2i, 3.14].any?(Numeric))
      expect([1, 2i, 3.14].my_any?(Float)).to eql([1, 2i, 3.14].any?(Float))
    end
    it "Returns true if any of the items match the argument" do
      expect(%w[cat cat cat].my_any?("cat")).to eql(%w[cat cat cat].any?("cat"))
      expect(%w[ant bear cat].my_any?("cat")).to eql(%w[ant bear cat].any?("cat"))
    end
    it "Returns true if any of the values are truthy" do
      expect(["cat", true, 99].my_any?).to eql(["cat", true, 99].any?)
      expect([nil, true, 99].my_any?).to eql([nil, true, 99].any?)
    end
  end

  describe '#my_none?' do
    it 'Returns true when none of the items pass a test given in a block' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 3}).to eql(%w[ant bear cat].none? { |word| word.length >= 3 })
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eql(%w[ant bear cat].none? { |word| word.length >= 4 })
    end
    it "Returns true if none of the items match a Regex" do
      expect(%w[ant bear cat].my_none?(/t/)).to eql(%w[ant bear cat].none?(/t/))
      expect(%w[ant bear cat].my_none?(/b/)).to eql(%w[ant bear cat].none?(/b/))
    end
    it "Returns true if none of the items are part of a class" do
      expect([1, 2i, 3.14].my_none?(Numeric)).to eql([1, 2i, 3.14].none?(Numeric))
      expect([1, 2i, 3.14].my_none?(Float)).to eql([1, 2i, 3.14].none?(Float))
    end
    it "Returns true if none of the items match the argument" do
      expect(%w[cat cat cat].my_none?("cat")).to eql(%w[cat cat cat].none?("cat"))
      expect(%w[ant bear cat].my_none?("cat")).to eql(%w[ant bear cat].none?("cat"))
    end
    it "Returns true if none of the values are truthy" do
      expect(["cat", true, 99].my_none?).to eql(["cat", true, 99].none?)
      expect([nil, true, 99].my_none?).to eql([nil, true, 99].none?)
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
end
