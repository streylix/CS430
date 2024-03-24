require_relative "visitor"

class Expression
    def traverse(visitor, runtime)
        raise NotImplementedError, "Must implement 'traverse'."
    end
end