################################################################################
# Create metadata.
#
# @pattern Builder
# @see lib/meta for each meta.
################################################################################

require_relative 'meta'
# Require all meta from the meta directory.
Dir[File.join(__dir__, 'meta', '*.rb')].each { |file| require_relative file }

module Reflekt
  class MetaBuilder
    ##
    # Create meta type for matching data type.
    #
    # @logic
    #   1. First return basic type
    #   2. Then return custom type
    #   3. Then return "nil" type
    #
    # @param value [Dynamic] Any input or output.
    ##
    def self.create(value)
      meta = nil
      data_type = value.class.to_s

      case data_type
      when "Array"
        meta = ArrayMeta.new()
      when "TrueClass", "FalseClass"
        meta = BooleanMeta.new()
      when "Float"
        meta = FloatMeta.new()
      when "Integer"
        meta = IntegerMeta.new()
      when "String"
        meta = StringMeta.new()
      else
        unless value.nil?
          meta = ObjectMeta.new()
        end
      end

      unless meta.nil?
        meta.load(value)
      end

      meta
    end

    ##
    # Create meta for multiple values.
    #
    # @param values
    ##
    def self.create_many(values)
      meta = []

      values.each do |value|
        meta << self.create(value)
      end

      meta
    end

    ##
    # @param data_type [Type]
    ##
    def self.data_type_to_meta_type(value)
      data_type = value.class

      meta_types = {
        Array      => :array,
        TrueClass  => :bool,
        FalseClass => :bool,
        Float      => :float,
        Integer    => :int,
        NilClass   => :null,
        String     => :string
      }

      if meta_types.key? data_type
        return meta_types[data_type]
      elsif value.nil?
        return nil
      else
        return :object
      end
    end
  end
end
