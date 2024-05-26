# frozen_string_literal: true
require_relative 'privacy_accessed_api'

module Danger
  # This is your plugin class. Any attributes or methods you expose here will
  # be available from within your Dangerfile.
  #
  # To be published on the Danger plugins site, you will need to have
  # the public interface documented. Danger uses [YARD](http://yardoc.org/)
  # for generating documentation from your plugin source, and you can verify
  # by running `danger plugins lint` or `bundle exec rake spec`.
  #
  # You should replace these comments with a public description of your library.
  #
  # @example Ensure people are well warned about merging on Mondays
  #
  #          my_plugin.warn_on_mondays
  #
  # @see  shogo4405/danger-privacymanifest
  # @tags monday, weekends, time, rattata
  #
  class DangerPrivacymanifest < Plugin
    # A method that you can call from your Dangerfile
    # @return   [Array<String>]
    #
    def report
      privacy_accessed_apis = read_privacy_accessed_api_file
      active_files = (git.modified_files + git.added_files).uniq
      swift_files = active_files.select { |file| file.end_with?('.swift') }
      swift_files.each do |filename|
        file = File.read(filename)
        lines = file.lines
        lines.each do |line|
          privacy_accessed_apis.each do |privacy_accessed_api|
            next if privacy_accessed_api.api.empty?
            index = lines.index line
            text = "The '#{privacy_accessed_api.api}' is the require reason api. Please check privacy manifest files."
            warn(text, file: filename, line: index + 1) if line.gsub(/\.|\)/, ' ').split(/\s+/).include?(privacy_accessed_api.api)
          end
        end
      end
    end

    private

    def read_privacy_accessed_api_file
      apis = []
      file = File.open(File.expand_path('required-reason-api.tsv', File.dirname(__FILE__)), "rt").read
      file.lines.each do |line|
        apis.push(PrivacyAccessedAPI.generate(line))
      end
      apis
    end

  end
end
