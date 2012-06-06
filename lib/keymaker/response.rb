module Keymaker

  class Response

    attr_accessor :request
    attr_accessor :service
    attr_accessor :faraday_response

    def initialize(service, faraday_response)
      self.service = service
      self.faraday_response = faraday_response
    end

    def body
      faraday_response.body || {}
    end

    def status
      faraday_response.status
    end

    def neo4j_id
      body["self"] && body["self"][/\d+$/].to_i
    end

    def on_success
      if success?
        yield self
      end
    end

    def success?
      (200..207).include?(status)
    end

  end

end
