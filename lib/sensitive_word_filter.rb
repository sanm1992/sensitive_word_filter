require "sensitive_word_filter/version"
require "sensitive_word_filter/load"
require "sensitive_word_filter/scan"

class SensitiveWordFilter::Filter
  class Error < StandardError; end

  class << self
    def scan(text='', file_paths=[])
      new(file_paths).scan(text)
    end
  end

  attr_reader :file_paths

  def initialize(file_paths=[])
    if file_paths.empty?
      @words = SensitiveWordFilter::Load.new('lib/sensitive_word_filter/words/广告.text').load
    else
      @words = SensitiveWordFilter::Load.new(file_paths).load
    end
  end

  def scan(text='')
    SensitiveWordFilter::Scan.new(@words).scan(text)
  end
end
