module Voyeur
  class Mp4 < Converter

    def file_extension
      "mp4"
    end

    def convert_options
      "-b:v 1500k -vcodec libx264 -ab 160k -ac 2 -g 30"
    end
  end
end
