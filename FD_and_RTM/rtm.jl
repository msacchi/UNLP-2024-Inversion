"""
    rtm(nx, nz, nt, dx, dz, dt, f0, c, c0, npad, ix_s, iz_s, ix_r, iz_r)

Reverse Time Migration (RTM) computes the source and receiver wavefields and then compute the image.
The code reads shots gathers with position `ix_s,iz_s` with receivers in `ix_r,ix_r` from `shot_#.bin` files
where `#` is the shot number. The shots where simulated with `make_data.jl`.

# Arguments
- `nx`: number of grid points x
- `nz`: number of grid points z
- `nt`: number of time steps
- `dx`: x spatial grid sampling [meters]
- `dz`: x spatial grid sampling [meters]
- `dt`: number of time steps [seconds]
- `c`: media velocity as a matrix of size nx x nz [meters/seconds]
- `c0`: background velocity as a matrix of size nx x nz [meters/seconds]
- `npad`: number of grid points for absorbing area
- `ix_s`: source index x positions ns x 1 (integers)
- `iz_s`: source index z positions ns x 1 (integers)
- `ix_r`: receiver index x positions ns x 1 (integers)
- `iz_r`: receiver index z positions ns x 1 (integers) 
# Output
- `I`: image of size nx x nz

*Credits: MDS 2024*

"""
function rtm(nx, nz, nt, dx, dz, dt, f0, c, c0, npad, ix_s, iz_s, ix_r, iz_r)

  I = zeros(nx,nz)
 ns = length(ix_s) 
 nr = length(ix_r) 



 for k = 1:ns 

  data = read_bin("shot_"*string(k)*".bin",nr,nt) 

     S = source_2D(nx, nz, nt, dt, f0, ix_s[k], iz_s[k])
    WS =  afd_2D_f(nx, nz, nt, dx, dz, dt, c, npad, S)    # Source wavefield  WS(x,z,t)

     R = receiver_2D(nx, nz, nt, data, ix_r, iz_r)
    WR =  afd_2D_b(nx, nz, nt, dx, dz, dt, c, npad, R)    # Receiver wavefeild WR(x,z,t)


   I = I + dropdims(sum(WS.*WR,dims=3),dims=3):q


 end 

   Imax = maximum(I)
   I = I/Imax 

return I 
end

