# frozen_string_literal: true

require "resolv"

class RefinedURI
  attr_reader :uri, :url

  def initialize(url)
    @url = url.to_s
    @uri = URI.parse(url)
  end

  def invalid?
    !valid?
  end

  def valid?
    url.match?(URI::DEFAULT_PARSER.make_regexp(["http", "https"])) &&
      !localhost? &&
      !disallowed_ip_address?(uri.host) &&
      resolvable_host?
  end

  private

  def disallowed_ip_address?(host)
    ip_addr = IPAddr.new(host)
    ip_addr.loopback? || ip_addr.private?
  rescue IPAddr::InvalidAddressError
    false
  end

  def localhost?
    uri.host.match?(/^localhost$/i)
  end

  def resolvable_host?
    ip_addrs = Resolv.getaddresses(uri.host)

    return false if ip_addrs.none?

    ip_addrs.none? { |ip_addr| disallowed_ip_address?(ip_addr) }
  end
end
