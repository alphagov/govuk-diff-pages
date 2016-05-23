require "spec_helper"
require "rspec/core/rake_task"
load "./lib/govuk/diff/pages/tasks/rakefile.rake"

RSpec.describe "rakefile" do
  before do
    ENV.stub(:fetch).with("URI").and_return(FixtureHelper.locate("test_paths.yaml"))
  end

  describe "diff:html" do
    it "invokes Govuk::Diff::Pages::HtmlDiff::Runner with right parameters" do
      mocked_runner = double(Govuk::Diff::Pages::HtmlDiff::Runner, run: true)

      expect(Govuk::Diff::Pages::HtmlDiff::Runner).to receive(:new)
        .with(paths: %w(/government/stats/foo /government/stats/bar))
        .and_return(mocked_runner)

      Rake::Task["diff:html"].invoke
    end
  end

  describe "diff:visual" do
    it "invokes Govuk::Diff::Pages::HtmlDiff::Runner with right parameters" do
      mocked_runner = double(Govuk::Diff::Pages::VisualDiff::Runner, run: true)

      expect(Govuk::Diff::Pages::VisualDiff::Runner).to receive(:new)
        .with(paths: %w(/government/stats/foo /government/stats/bar))
        .and_return(mocked_runner)

      Rake::Task["diff:visual"].invoke
    end
  end
end
