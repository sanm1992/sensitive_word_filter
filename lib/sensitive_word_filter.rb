require "sensitive_word_filter/version"
require "sensitive_word_filter/load"
require "sensitive_word_filter/scan"

module SensitiveWordFilter
  class Error < StandardError; end

  def self.scan(text='', file_paths=[])
    Filter.new(file_paths).scan(text)
  end

  class Filter
    attr_reader :file_paths

    def initialize(file_paths=[])
      if file_paths.empty?
        raise Error.new('sensitive words file path is empty')
      else
        @words = Load.new(file_paths).load
      end
    end

    def scan(text='')
      Scan.new(@words).scan(text)
    end
  end
end