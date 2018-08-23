"""
    RangeNumber(v, r)

# Example
a = RangeNumber(3, 1:7)
"""
struct RangeNumber{T<:Number, R}
    v::T

    function RangeNumber(v::Number, r::UnitRange)
        v in r || error("$v not in $r")
        return new{typeof(v), r}(v)
    end
end
