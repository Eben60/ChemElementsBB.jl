
Base.getindex(e::ChemElems, i::Integer) = e.data[e.bynumber[i]]
Base.getindex(e::ChemElems, i::AbstractString) = e.data[e.byname[lowercase(i)]]
Base.getindex(e::ChemElems, i::Symbol) = e.data[e.bysymbol[i]]
Base.getindex(e::ChemElems, v::AbstractVector) = ChemElem[e[i] for i in v]
Base.haskey(e::ChemElems, i::Integer) = haskey(e.bynumber, i)
Base.haskey(e::ChemElems, i::AbstractString) = haskey(e.byname, lowercase(i))
Base.haskey(e::ChemElems, i::Symbol) = haskey(e.bysymbol, i)


# support iterating over ChemElems
Base.eltype(e::ChemElems) = ChemElem
Base.length(e::ChemElems) = length(e.data)
Base.iterate(e::ChemElems, state...) = iterate(e.data, state...)


# Since Element equality is determined by atomic number alone...
Base.isequal(elm1::ChemElem, elm2::ChemElem) = elm1.atomic_number == elm2.atomic_number

# There is no need to use all the data in Element to calculated the hash
# since Element equality is determined by atomic number alone.
Base.hash(elm::ChemElem, h::UInt) = hash(elm.atomic_number, h)

# Compare elements by atomic number to produce the most common way elements
# are sorted.
Base.isless(elm1::ChemElem, elm2::ChemElem) = elm1.atomic_weight < elm2.atomic_weight

# Provide a simple way to iterate over all elements.
Base.eachindex(elms::ChemElems) = eachindex(elms.data)


Base.promote_rule(::Type{T1}, ::Type{T2}) where {T1 <: ChemElem} where {T2 <: Real} = Float64
Base.Float64(x::ChemElem) = x.atomic_weight