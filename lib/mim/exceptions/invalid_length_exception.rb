module Mim
  class InvalidLengthException < StandardError
    def message
      'Input length must be between 1 and 30 characters'
    end
  end
end
