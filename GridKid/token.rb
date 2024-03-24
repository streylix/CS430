class Token
    attr_reader :type, :text

    def initialize(type, text)
        @type = type
        @text = text
    end
end
