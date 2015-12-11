# Avdi's magic sauce
module Keymaker
  module MatchMethodMacros
    def match_method(matcher, &method_body)
      mod = Module.new do
        define_method(:method_missing) do |method_name, *args|
          if matcher === method_name.to_s
            instance_exec(method_name, *args, &method_body)
          else
            super(method_name, *args)
          end
        end

        define_method(:respond_to_missing?) do |method_name, include_private|
          # Even though this is in the #respond_to_missing? hook we
          # still need to call 'super' in case there are other included
          # modules which also define #respond_to_missing?
          (matcher === method_name) || super(method_name, include_private)
        end
      end
      include mod
    end
  end
end
