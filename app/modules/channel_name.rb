module ChannelName
  # Normalize using the SNP name
  # SNP names are constructed by the following rules:
  # * lowercase
  # * letters a to z
  # * numbers 0 to 9
  # * replace & with and
  # * replace + with plus
  # * replace * with star
  def to_snp(callsign)
    snp_map = {
      '&' => 'and',
      '+' => 'plus',
      '*' => 'star',
    }
    callsign = callsign.downcase()
    callsign = callsign.gsub(Regexp.union(snp_map.keys), snp_map)
    callsign = callsign.gsub(/[^a-z0-9]/, '')
    @snp_name = callsign
  end
end
