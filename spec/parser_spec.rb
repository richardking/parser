require 'helper'

describe Parser do
  subject { JSON.parse(Parser.new("spec/fixtures/valid_data.bdi").build_json) }

  its(["batch"]) { should eq("99") }
  its(["description"]) { should eq("Payroll for January") }
  its("size") { should eq(3) }

  context "invalid file type" do
    it 'should raise error' do
      expect{Parser.new("spec/fixtures/invalid_file_type.bdi").build_json}.to raise_error(InvalidFileTypeError)
    end
  end
end
