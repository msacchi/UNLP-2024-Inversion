"""
    rtm_p(nx, nz, nt, dx, dz, dt, f0, c, c0, npad, ix_s, iz_s, ix_r, iz_r)

RTM code, computes source wavefield and receiver wavefield and then compute the image 

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
- `ix_s`: source index x positions ns x 1
- `iz_s`: source index z positions ns x 1
- `ix_r`: receiver index x positions ns x 1
- `iz_r`: receiver index z positions ns x 1
# Output
- `I`: image of size nx x nz

*Credits: MDS 2024*

"""
function rtm_p(nx, nz, nt, dx, dz, dt, f0, c, c0, npad, ix_s, iz_s, ix_r, iz_r)

 ns = length(ix_s) 
  I = zeros(nx,nz,ns)
 nr = length(ix_r) 


 for k = 1:ns 

  filename = "shot_"*string(k)*".bin"
  println("Read shot ", k, " from ", filename) 
  fid = open(filename,"r");
  data = zeros(Float64,nr*nt);
  read!(fid,data);
  close(fid)
  data = reshape(data,nr,nt);

     S = source_2D(nx, nz, nt, dt, f0, ix_s[k], iz_s[k])
    WS =  afd_2D_f(nx, nz, nt, dx, dz, dt, c, npad, S)    # Source wavefield  WS(x,z,t)

     R = receiver_2D(nx, nz, nt, data, ix_r, iz_r)
    WR =  afd_2D_b(nx, nz, nt, dx, dz, dt, c, npad, R)  # Receiver wavefeild WR(x,z,t)


   I[:,:,k] = dropdims(sum(WS.*WR,dims=3),dims=3)

 end 

return I 
end

