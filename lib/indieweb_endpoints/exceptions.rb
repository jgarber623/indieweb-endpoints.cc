module IndiewebEndpoints
  class BadRequest < StandardError
    def http_status
      400
    end
  end

  class MethodNotAllowed < StandardError
    def http_status
      405
    end
  end

  class RequestTimeout < StandardError
    def http_status
      408
    end
  end
end
