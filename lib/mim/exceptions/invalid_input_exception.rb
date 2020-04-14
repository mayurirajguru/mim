module Mim
  class InvalidInputException < StandardError
    def message
      'Input must consist of ascii characters only'
    end
  end
end
