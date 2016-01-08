module Embulk
  module Filter

    class Script < FilterPlugin
      Plugin.register_filter('script', self)

      def self.transaction(config, in_schema, &control)
        task = {
          'path'  => config.param('path', :string),
          'drop_columns' => config.param('drop_columns', :array, default: [])
        }
        out_schema = out_schema(task['drop_columns'], in_schema)
        yield(task, out_schema)
      end

      def self.out_schema(drop_columns, in_schema)
        idx = 0
        schema = []
        in_schema.each do |sch|
          unless drop_columns.find {|n| n == sch.name}
            schema << Column.new(idx, sch.name, sch.type, sch.format)
            idx += 1
          end
        end
        schema
      end

      def initialize(task, in_schema, out_schema, page_builder)
        super
        load_script_file(task['path'])
      end

      def add(page)
        task
        page.each do |record|
          result = {}
          filter(hash_record(record)).each do |key, value|
            unless task['drop_columns'].find {|n| n == key }
              result[key] = value
            end
          end
          @page_builder.add(result.values)
        end
      end

      def finish
        @page_builder.finish
      end

      private

      def load_script_file(path)
        raise ConfigError, "Ruby script file does not exist: #{path}" unless File.exist?(path)
	eval "self.instance_eval do;" + IO.read(path) + ";end"
      end

      def hash_record(record)
        Hash[in_schema.names.zip(record)]
      end
    end
  end
end
