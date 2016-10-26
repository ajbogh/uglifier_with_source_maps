module Sprockets
  module Compressors
    extend self
    
    register_js_compressor(:uglify_with_source_maps, 'UglifierWithSourceMaps::Compressor', require: "uglifier_with_source_maps")
    register_js_compressor(:uglifier_with_source_maps, 'UglifierWithSourceMaps::Compressor', require: "uglifier_with_source_maps")
    
    def register_js_compressor(name, klass, options = {})
      @@default_js_compressor = name.to_sym if options[:default] || @@default_js_compressor.nil?
      @@js_compressors[name.to_sym] = {:klass => klass.to_s, :require => options[:require]}
    end
  end
  class LazyCompressor #:nodoc:
    def compress(data, context = nil)
      if compressor.instance_of?(UglifierWithSourceMaps::Compressor)
        compressor.compress(data, context)
      else
        compressor.compress(data)
      end
    end
  end
end
