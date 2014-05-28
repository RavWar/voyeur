module Voyeur
  class Ogg < Converter

    def file_extension
      'ogg'
    end

    def convert_options
      '-acodec libvorbis'
    end
  end
end
