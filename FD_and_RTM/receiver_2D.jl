"""
    receiver_2D(nx, nz, nt, data, ix_r, iz_r)

Insert data  into the righ hand side of the adjoint operator

# Arguments
- `nx`: number of grid points x
- `nz`: number of grid points z
- `nt`: number of time steps
- `data`: data as matrix of size nr x nt
- `ix_r`: vector with receiver x grid index positions nr x 1
- `iz_r`: vector with receiver z grid index positions nr x 1
# Output
- `source`: source term of size nx x nz x nt. This program makes `source` injected in `afd_2D_b.jl`

*Credits: MDS 2024*

"""
function receiver_2D(nx, nz, nt, data, ix_r, iz_r)

 nr = length(ix_r)

 source = zeros(nx,nz,nt)

# Inject data as source in 3D tensor in the grid point positios where
# we have recievers

  for it in 1:nt
   for ir in 1:nr
    source[ix_r[ir],iz_r[ir],it] = data[ir,it]
   end
  end

  return source
 end 
 


