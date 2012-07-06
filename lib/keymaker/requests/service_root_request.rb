module Keymaker

  class ServiceRootRequest < Request

    def submit
      service.get("db/data/", opts)
    end

  end

end
