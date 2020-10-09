require "sensitive_word_filter/dfa_tree"

module SensitiveWordFilter
  class Scan
    attr_accessor :sensitive_map

    def initialize(words=[])
      @sensitive_map = DfaTree.new(words).dfa_tree
    end

    def scan(text = '')
      return [] if  text.nil?
      _scan(gsub_text(text))
    end

    private

    def _scan(text = '', sensitive_words = [], sensitive_hash = sensitive_map, temp_text = '')
      c = text[0]
      return sensitive_words if text.empty?
      return sensitive_words if c.empty?

      text_size = text.length
      w = sensitive_hash[c]

      if w.nil?
        if temp_text.size > 0
          new_text = temp_text + text
          new_length = new_text.length
          text = new_text[1..(new_length-1)]
        else
          text = text[1..(text_size-1)]
        end
        temp_text = ''
        send(__method__, text, sensitive_words)
      else
        temp_text += c
        text = text[1..(text_size-1)]
        if w.is_end
          sensitive_words.push(temp_text)
          send(__method__, text, sensitive_words)
        else
          send(__method__, text, sensitive_words, w.value, temp_text)
        end
      end
    end

    def gsub_text(text)
      text.strip.gsub(/[`~!@#$^&*()=|{}':;',\\\[\]\.<>\/?~！@#￥……&*（）——|{}【】'；：""'。，、？]|\s/,'')
    end
  end
end