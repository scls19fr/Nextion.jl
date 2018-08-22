abstract type AbstractNexResource end


struct Font <: AbstractNexResource
    id::UInt8
end
Font(id::Number) = Font(UInt8(id))


struct Picture <: AbstractNexResource
    id::UInt8
end
Picture(id::Number) = Picture(UInt8(id))
