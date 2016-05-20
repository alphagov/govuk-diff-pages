describe Govuk::Diff::Pages::VisualDiff::Runner do
  describe "#run" do
    let(:kernel) { double }
    let(:input_file) { FixtureHelper.locate("test_paths.yaml") }
    let(:config_handler_klass) { Govuk::Diff::Pages::VisualDiff::WraithConfig }
    let(:config_handler) { config_handler_klass.new(paths: YAML.load_file(input_file)) }

    before do
      allow(config_handler_klass).to receive(:new).and_return(config_handler)
      allow(config_handler).to receive_messages(write: nil, delete: nil)
      allow(kernel).to receive(:system)
    end

    it "executes wraith with the appropriate config" do
      expect(config_handler_klass).to receive(:new).with(paths: ["/government/stats/foo", "/government/stats/bar"])
      expect(config_handler).to receive(:write)
      expect(kernel).to receive(:system).with("wraith capture #{config_handler.location}")
      expect(config_handler).to receive(:delete)

      expect { described_class.new(list_of_pages_uri: input_file, kernel: kernel).run }.to output(
        "---> Creating Visual Diffs\n" +
        "running: wraith capture #{config_handler.location}\n"
      ).to_stdout
    end
  end
end
