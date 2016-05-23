describe Govuk::Diff::Pages::HtmlDiff::Runner do
  before { allow(Kernel).to receive(:puts) } # silence stdout for the test

  after(:all) do
    FileUtils.rm_r(described_class.results_dir, secure: true) if Dir.exist?(described_class.results_dir)
  end

  let(:input_paths) { FixtureHelper.load_paths_from("test_paths.yaml") }

  describe "#run" do
    it "runs the differ against the provided paths, and builds a gallery of diffs" do
      mock_differ = double(
        "Govuk::Diff::Pages::HtmlDiff::Differ",
        diff: nil,
        differing_pages: { "/government/stats/foo" => "some-diff" }
      )

      allow(Govuk::Diff::Pages::HtmlDiff::Differ).to receive(:new).and_return(mock_differ)

      expect(mock_differ).to receive(:diff).with("/government/stats/foo").once
      expect(mock_differ).to receive(:diff).with("/government/stats/bar").once

      Govuk::Diff::Pages::HtmlDiff::Runner.new(paths: input_paths).run

      gallery_file_location = "#{described_class.results_dir}/gallery.html"
      expect(File.exist? gallery_file_location).to be true
      gallery_contents = IO.read(gallery_file_location)
      expect(gallery_contents).to include("1 pages out of 2 compared have differences")
      expect(gallery_contents).to include("/government/stats/foo")
      expect(gallery_contents).to_not include("/government/stats/bar")
    end
  end
end
