module Nokogiri
  module XML
    class Document < Node
      include DOM::Document

      def decorators
        @decorators ||= Hash.new { |h,k| h[k] = [] }
      end

      def name
        'document'
      end

      ###
      # Apply any decorators to +node+
      def decorate(node)
        key = node.class.name.split('::').last.downcase
        decorators[key].each do |klass|
          node.extend(klass)
        end
      end

      def to_xml
        serialize
      end

      def namespaces
        root ? root.collect_namespaces : {}
      end
    end
  end
end
