# danger-privacymanifest

This is a danger plugin that points out when an API requiring PrivacyManifest support is utilized. The list of APIs is managed here. If there are any additions or changes, please update the [spreadsheet](https://docs.google.com/spreadsheets/d/1Dnbl5mYpKh7PY4OMuWEPmojRmDZphNEN1cp7-p2k2lk/edit#gid=0) and submit a PR for .tsv updates.


## Installation

    $ gem install danger-privacymanifest

## Usage

    Methods and attributes from this plugin are available in
    your `Dangerfile` under the `privacymanifest` namespace.

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
