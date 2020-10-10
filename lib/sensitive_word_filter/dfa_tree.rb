module SensitiveWordFilter
  class DfaTree
    Word = Struct.new(:is_end, :value)

    attr_accessor :words, :tree

    def initialize(words=nil)
      @tree = Hash.new
      @words = words || []
    end

    def dfa_tree
      words.each do |word|
        word_hash = tree
  
        _word = word.strip
        word_length = _word.length
  
        (1..word_length).each do |i|
          c = _word[i-1]
          if word_hash[c].nil?
            if i == word_length
              word_hash[c] = Word.new(true, Hash.new)
            else
              word_hash[c] = Word.new(false, Hash.new)
              word_hash = word_hash[c].value
            end
          else
            word_hash = word_hash[c].value
          end
        end
      end
      tree
    end
  end
end