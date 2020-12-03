require 'Meta'

class ArrayMeta < Meta

  def initialize()

    @type = :array
    @min = nil
    @max = nil
    @length = nil

  end

  ##
  # @param value [Array]
  ##
  def load(value)

    @min = value.min()
    @max = value.max()
    @length = value.length()

  end

  def result()
    {
      :type => @type,
      :max => @max,
      :min => @min,
      :length => @length
    }
  end

end
