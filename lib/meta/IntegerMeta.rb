require 'Meta'

class IntegerMeta < Meta

  def initialize()

    @type = :int
    @value = nil

  end

  ##
  # @param value [Integer]
  ##
  def load(value)
    @value = value
  end

  def result()
    {
      :type => @type,
      :value => @value
    }
  end

end
