module Mim
  class UnknownCommandException < StandardError
    def message
      'Unknown command'
    end
  end
end
