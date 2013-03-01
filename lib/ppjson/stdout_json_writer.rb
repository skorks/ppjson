module Ppson
  class StdoutJsonWriter
    def write(contents, options = {:pretty => false})
      Ppjson::StreamJsonWriter.new.write(contents, :pretty => options[:pretty])
    end
  end
end
