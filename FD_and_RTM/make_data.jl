"""
    make_data(nx, nz, nt, dx, dz, dt, f0, c, c0, npad, ix_s, iz_s, ix_r, iz_r)

Make several shot gathers and save them as binary files

# Arguments
- `nx`: number of grid points x
- `nz`: number of grid points z
- `nt`: number of time steps
- `dt`: number of time steps [seconds]
- `f0`: central frequency of min phase Ricker wavelet
- `c0`: background velocity in meters/seconds as matrix of size nx x nz
- `c`: migration  velocity in meters/seconds as matrix of size nx x nz
- `npad`: size of padding are for sponge ABC
- `ix_s`: source x grid index position
- `iz_s`: source z grid index position
- `ix_r`: receiver x grid index positions nr x 1
- `iz_r`: receiver z grid index positions nr x 1
# Output
-  shot gathers in files `shot_n.bin` where n is the shot number, n=1:nr  

*Credits: MDS 2024*

"""
function make_data(nx, nz, nt, dx, dz, dt, f0, c, c0, npad, ix_s, iz_s, ix_r, iz_r)

 ns = length(ix_s);

for k = 1:ns

   println("       Shot : ",k, " of ", ns)
 
   s  = source_2D(nx, nz, nt, dt, f0, ix_s[k], iz_s[k])
  d   =    afd_2D(nx, nz, nt, dx, dz, dt, c , npad, s, ix_r,iz_r)[1] 
  d0  =    afd_2D(nx, nz, nt, dx, dz, dt, c0, npad, s, ix_r,iz_r)[1] 

  data = d-d0 

  filename = "shot_"*string(k)*".bin"

  write_bin(filename,data)

end

return
end

