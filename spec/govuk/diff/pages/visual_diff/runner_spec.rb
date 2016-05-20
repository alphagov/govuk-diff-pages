describe Govuk::Diff::Pages::VisualDiff::Runner do
  describe "#run" do
    let(:yaml_file_uri) { FixtureHelper.locate("test_paths.yaml") }
    let(:config_klass) { Govuk::Diff::Pages::VisualDiff::WraithConfig }
    before { allow(Kernel).to receive(:puts) } # silence stdout for the test

    it "executes wraith with the appropriate config" do
      config_handler = config_klass.new(paths: ["/government/stats/foo", "/government/stats/bar"])
      allow(config_klass).to receive(:new).and_return(config_handler)
      allow(config_handler).to receive_messages(write: nil, delete: nil)

      expect(config_klass).to receive(:new).with(paths: ["/government/stats/foo", "/government/stats/bar"])
      expect(config_handler).to receive(:write)
      expect(Kernel).to receive(:system).with("wraith capture #{config_handler.location}")
      expect(config_handler).to receive(:delete)

      Govuk::Diff::Pages::VisualDiff::Runner.new(list_of_pages_uri: yaml_file_uri).run
    end
  end
end
