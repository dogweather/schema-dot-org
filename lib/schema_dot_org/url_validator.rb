# frozen_string_literal: true

require 'uri'

module SchemaDotOrg
  # Utility module for URL validation
  module UrlValidator
    # Validates that a string is a proper web URL (HTTP/HTTPS with a host)
    #
    # @param url [String]  The URL string to validate
    # @return    [Boolean] true if the URL is valid, false otherwise
    #
    # Doc Tests:
    #   >> SchemaDotOrg::UrlValidator.valid_web_url?('https://example.com')     #=> true
    #   >> SchemaDotOrg::UrlValidator.valid_web_url?('http://example.com/path') #=> true
    #   >> SchemaDotOrg::UrlValidator.valid_web_url?('ftp://example.com')       #=> false
    #   >> SchemaDotOrg::UrlValidator.valid_web_url?('not-a-url')               #=> false
    #   >> SchemaDotOrg::UrlValidator.valid_web_url?('')                        #=> false
    #   >> SchemaDotOrg::UrlValidator.valid_web_url?(nil)                       #=> false
    #   >> SchemaDotOrg::UrlValidator.valid_web_url?('https://example.com')     #=> true
    #
    def self.valid_web_url?(url)
      return false if url.nil? || url.to_s.strip.empty?

      uri = URI.parse(url.to_s)

      # Check for valid HTTP/HTTPS scheme
      return false unless %w[http https].include?(uri.scheme)

      # Check for a host
      return false if uri.host.nil? || uri.host.strip.empty?

      true
    rescue URI::InvalidURIError
      false
    end
  end
end
