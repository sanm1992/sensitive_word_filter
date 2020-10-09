module SensitiveWordFilter
  class Load
    attr_accessor :words
    attr_reader :file_paths

    def initialize(file_paths)
      @file_paths = file_paths
      @words = Array.new
    end

    def load
      if file_paths.is_a?(Array)
        file_paths.each do |file_path|
          _load(file_path)
        end
      else
        _load(file_paths)
      end

      words
    end

    private

    def _load(file_path)
      f = File.open(file_path, "r")
      f.each_line do |line|
        words.push(line.gsub("\n", ''))
      end
      f.close
    end
  end
end