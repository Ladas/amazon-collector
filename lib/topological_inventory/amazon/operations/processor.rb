require "topological_inventory/amazon/logging"
require "topological_inventory/amazon/operations/source"
require "topological_inventory/providers/common/operations/processor"

module TopologicalInventory
  module Amazon
    module Operations
      class Processor < TopologicalInventory::Providers::Common::Operations::Processor
        include Logging

        def operation_class
          "#{Operations}::#{model}".safe_constantize
        end
      end
    end
  end
end
