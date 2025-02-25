class Request
  attr_reader :method, :path, :headers, :body, :query

  def initialize(request)
    lines = request.lines
    index = lines.index("\r\n")

    @method, @path, _ = lines.first.split
    @path, @query = @path.split("?")
    @headers = parse_headers(lines[1...index])
    @body = lines[(index + 1)..-1].join
  end

  def parse_headers(lines)
    headers = {}

    lines.each do |line|
      name, value = line.split(": ")
      headers[name.downcase] = value.chomp
    end

    headers
  end
end