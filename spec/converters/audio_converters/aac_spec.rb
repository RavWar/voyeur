require 'spec_helper'

describe Voyeur::Aac do
  let(:converter) { Voyeur::Converter.create(format: :aac) }
  let(:audio) { Voyeur::Media.new(filename: valid_mpeg_file_path) }

  it "should use the correct factory" do
    converter.class.to_s.should == "Voyeur::Aac"
  end

  it "default convert string" do
    converter.convert_options.should == "-acodec libfaac -ac 2 -ar 44100 -ab 128k"
  end

  context "A valid audio files" do
    after :each do
      File.delete(valid_mpeg_file_path.gsub(/mpeg/, "aac")) if File.exists?(valid_mpeg_file_path.gsub(/mpeg/, "aac"))
    end

    context "#convert_options: " do
      it "names the file correctly" do
        converter.convert(media: audio)
        output_file = valid_mpeg_file_path.gsub(/mpeg/, "aac")
        converter.output_media.filename.should == output_file
      end

      it "returns an audio file" do
        converter.convert(media: audio)
        converter.input_media.should == audio
      end

      context "audio file - " do
        it "returns conversion status indicating success" do
          result = converter.convert(media: audio)
          result[:status].should == 0
          result[:media].should == converter.output_media
        end

        it "allows it to be named" do
          result = converter.convert(media: audio)
          result[:status].should == 0
          result[:media].should == converter.output_media
        end
      end
    end
  end

  context "An invalid audio file" do
    let(:audio) { Voyeur::Media.new(filename: 'test_media.mpeg') }

    it "returns conversion status indicating failure" do
      result = converter.convert(media: audio)
      result[:status].should == 1
      result[:media].should == converter.output_media
      result[:error_message].should match(/test_media.mpeg: No such file or directory/)
      result[:stderr].nil?.should == false
    end
  end
end
