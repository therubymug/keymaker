require 'forwardable'

module Keymaker
  class Error < StandardError; end
  class HttpError < Error
    extend Forwardable

    attr_reader :response

    def_delegator :response, :status

    def initialize(response, message=response.status.to_s)
      @response = response
      super(message)
    end
  end
  class UserError < Error; end
  class UnknownAttributeError < UserError; end
  class ClientError < HttpError; end
  class ConflictError < ClientError; end
  class ResourceNotFound < ClientError; end
  class ServerError < HttpError; end
  class BatchRequestError < ServerError; end
end
