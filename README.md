# govuk-diff-pages

This app provides a set of rake tasks that produce diffs of the staging and
production GOV.UK websites. Diffs are provided in 3 distinct forms:

* Visual
  * Screenshots of pages in each environment, compared and presented in an HTML
    gallery for viewing in a browser.
* HTML
  * Diffs of the markup on each page, also presented in gallery form.
* Text
  * Diffs of text content on each page, with the results sent to STDOUT.

## Visual Diffs
These use a fork of the BBC's wraith gem (https://github.com/alphagov/wraith).
The fork adds two extra configuration variables, allowing the user to specify
the number of threads to use, and the maximum timeout when loading pages.

### Running
The rake task expects an env var `URI` to be set - this should be the location
of a YAML file containing a list of GOV.UK paths to run the diff against. See
spec/fixtures/test_paths.yaml for an example.

    bundle exec rake diff:visual URI=https://uri/to/a/yaml/file.yaml

Results are written to `$PROJECT_ROOT/results/visual/gallery.html`.

### Dependencies
The following are required in order to run a visual diff. A pre-flight check
for these dependencies runs when you execute the `diff:visual` task.

- [ImageMagick](http://www.imagemagick.org/script/index.php)
- [phantomjs](http://phantomjs.org/) - preferrably 1.9 rather than 2.0

### Examples
![Example output](docs/screenshots/gallery.png?raw=true "Example gallery of
differing pages")

## HTML Diffs
These use Diffy gem (https://github.com/samg/diffy) as the underlying diff
library.

### Running
Expects `URI` to be set, as with Visual Diffs.

    bundle exec rake diff:html URI=https://uri/to/a/yaml/file.yaml

Results are written to `$PROJECT_ROOT/results/html/gallery.html`.

## Text Diffs
These also use Diffy gem.

### Running
    bundle exec rake diff:text pages.yml

Where `pages.yml` is a YAML array of paths to compare. For example:

```
- government/organisations/prime-ministers-office-10-downing-street
- government/topical-events/budget-2016
- topic/competition/regulatory-appeals-references
```

Text diffs can also specify the domains to compare using the `LEFT` and `RIGHT`
environment variables. Defaulting to our `www-origin.staging` and
`www-origin.publishing` domains respectively.

Plain-text diffing can be parallelised by starting multiple processes with
individual page files.

## Running the test suite

    bundle exec rspec

## Licence

[MIT License](LICENCE.txt)
