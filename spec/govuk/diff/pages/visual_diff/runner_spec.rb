describe Govuk::Diff::Pages::VisualDiff::Runner do
  describe "#run" do
    let(:yaml_file_uri) { FixtureHelper.locate("test_paths.yaml") }
    let(:config_klass) { Govuk::Diff::Pages::VisualDiff::WraithConfig }
    before { allow(Kernel).to receive(:puts) } # silence stdout for the test

    it "executes wraith with the appropriate config" do
      mock_config_handler = double("#{config_klass}", location: "some/file/path")
      allow(config_klass).to receive(:new).and_return(mock_config_handler)

      expect(config_klass).to receive(:new).with(pages: ["/government/stats/foo", "/government/stats/bar"])
      expect(mock_config_handler).to receive(:write)
      expect(Kernel).to receive(:system).with("wraith capture some/file/path")
      expect(mock_config_handler).to receive(:delete)

      Govuk::Diff::Pages::VisualDiff::Runner.new(list_of_pages_uri: yaml_file_uri).run
    end
  end
end
