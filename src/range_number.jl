abstract type AbstractRangeNumber end

Number(rn::AbstractRangeNumber) = rn.v


#struct NoRangeNumber{T<:Number} <: AbstractRangeNumber
#    v::T
#    function NoRangeNumber(v::Number)
#        return new{typeof(v)}(v)
#    end
#end


"""
    RangeNumber(v, r)

# Example
a = RangeNumber(3, 1:7)
"""
struct RangeNumber{T<:Number, R} <: AbstractRangeNumber
    v::T

    function RangeNumber(v::Number, r::UnitRange)
        v in r || error("$v not in $r")
        return new{typeof(v), r}(v)
    end
end

RangeNumber{T, R}(n) where {T, R} = RangeNumber(n, R)

Base.:+(a::RangeNumber{T, R}, b::RangeNumber{T, R}) where {T, R} = RangeNumber(a.v+b.v, R)
Base.:+(a::Number, b::RangeNumber{T, R}) where {T, R} = RangeNumber(a+b.v, R)
Base.:+(a::RangeNumber{T, R}, b::Number) where {T, R} = RangeNumber(a.v+b, R)

Base.:(==)(a::RangeNumber{T, R}, b::RangeNumber{T, R}) where {T, R} = a.v == b.v
Base.:(==)(a::Number, b::RangeNumber{T, R}) where {T, R} = a == b.v
Base.:(==)(a::RangeNumber{T, R}, b::Number) where {T, R} = a.v == b

