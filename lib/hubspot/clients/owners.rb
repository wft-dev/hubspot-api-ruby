Dir["#{ROOT_PATH}/hubspot/clients/*.rb"]
Dir["#{ROOT_PATH}/hubspot/codegen/crm/owners/**/*.rb"].each { |f| require f }

module Hubspot
  module Clients
    class Owners < Clients::Base
      API = %w[DefaultApi]

      API.each do |api_name|
        define_method(Util.underscore(api_name)) do
          api_class = Hubspot.const_get("Client::Crm::Owners::Api::#{api_name}")
          method_name = Util.underscore(api_name)
          if instance_variable_defined?("@#{method_name}")
            instance_variable_get("@#{method_name}")
          else
            instance_variable_set("@#{method_name}", api_class.new(@api_client))
          end
        end
      end
    end
  end
end