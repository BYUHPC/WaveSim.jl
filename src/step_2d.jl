export step!



"""
    step!(w::WaveOrthotope, dt=$defaultdt)

Update `w` by `dt` seconds in one step using leapfrog integration.
"""
function step!(w::WaveOrthotope{<:Real, 2}, dt=defaultdt)
    dt < 0 && throw(ArgumentError("Stepping back is not supported by this implementation"))
    # Helpers
    m, n = size(w)
    c = w.c
    u = view(w.u, axes(w)...)
    v = view(w.v, axes(w)...)
    # Update v
    for i in 2:m-1, j in 2:n-1
        L = (u[i-1,j] + u[i+1,j] + u[i,j-1] + u[i,j+1]) / 2 - 2 * u[i,j]
        v[i,j] = (1 - dt * c) * v[i,j] + dt * L
    end
    # Update u
    for i in 2:m-1, j in 2:n-1
        u[i,j] += v[i,j] * dt
    end
    # Update simulation time and return
    w.t[] += dt
    return w
end
