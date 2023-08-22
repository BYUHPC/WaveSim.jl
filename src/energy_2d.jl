export energy



"""
    energy(w::WaveOrthotope, component=:total)

Return the specified component of the energy contained in `w`.

`compoment` can be `:total`, `:dynamic`, or `:potential`.
"""
function energy(w::WaveOrthotope{<:Real, 2}, component=:total)
    component in (:total, :dynamic, :potential) ||
            throw(ArgumentError("Energy component must be :total, :dynamic, or :potential"))
    m, n = size(w)
    u, v = w.u, w.v
    E = 0
    # Dynamic
    for i in 2:m-1, j in 2:n-1
        if component != :potential E += v[i,j]^2 / 2 end
    end
    # Potential
    for i in 1:m-1, j in 2:n-1 # along x axis (note i range)
        if component != :dynamic E += (u[i,j] - u[i+1,j])^2 / 4 end
    end
    for i in 2:m-1, j in 1:n-1 # along y axis (note j range)
        if component != :dynamic E += (u[i,j] - u[i,j+1])^2 / 4 end
    end
    # Return the total
    return E
end
