"""
    damping_2D(nx, nz, D; fact=0.000015, degree=2)

Damping area matrix to impose absorving boundary conditions

# Arguments
- `nx`: number of grid points x
- `nz`: number of grid points z
- `D`: size of padding area
# Keywors
- `fact`: maximum damping
- `degree`: polynomial damping degree 
# Output
-  `a`: damping matrix of size nx x nz. The elements are zero in the central area and grow
smoothly to `fact` in the sponge area of size `D`

*Credits: MDS 2024*

"""
function damping_2D(nx, nz, D; fact=0.000015, degree=2)

    a = zeros(nx,nz)

    for i in 1:nx
        for j in 1:nz
            d_i = min(i - 1, nx - i)  # Distance from the nearest horizontal boundary
            d_j = min(j - 1, nz - j)  # Distance from the nearest vertical boundary
            d = min(d_i, d_j)         # Minimum distance to any boundary
            if d < D
                a[i, j] = (1 - d / D)
            else
                a[i, j] = 0.0
            end
        end
    end

    a = a.^degree*fact
    
    return a
end


