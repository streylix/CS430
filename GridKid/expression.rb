require_relative "visitor"

class Expression
    def traverse(visitor)
        raise NotImplementedErr, "Must implement 'traverse'."
    end
end