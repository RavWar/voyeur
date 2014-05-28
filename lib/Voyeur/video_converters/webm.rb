module Voyeur
  class Webm < Converter

    def file_extension
      "webm"
    end

    def convert_options
      "-b:v 1500k -vcodec libvpx -acodec libvorbis -ab 160k -ac 2 -g 30"
    end
  end
end
