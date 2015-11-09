module ICMC
  class NginxService < ICMCService
    getter name
    @name = "nginx"

    # ROUTES = { "NGINX": {
    #   "HOST": {
    #     "CREATE": host_create,
    #     "DESTROY": host_destroy,
    #     "ENABLE": host_enable,
    #     "DISABLE": host_disable,
    #     "CREATE_AND_ENABLE", host_create_and_enable
    #     },
    #   "STATUS": status
    #   }
    # }

    def self.routes
      {
        "HOST": {
          "CREATE":            host_create,
          "DESTROY":           host_destroy,
          "ENABLE":            host_enable,
          "DISABLE":           host_disable,
          "CREATE_AND_ENABLE": host_create_and_enable,
        },
        "STATUS": status,
      }
    end

    def host_create
    end

    def host_destroy
    end

    def host_enable
    end

    def host_disable
    end

    def host_create_and_enable
    end
  end
end
