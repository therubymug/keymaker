module Keymaker

  class ServiceRootRequest < Request

    def submit
      service.get("db/data/", {})
    end

  end

end
