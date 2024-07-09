using SeisProcessing
using PyPlot

include("damping_2D.jl")
include("source_2D.jl")
include("afd_2D.jl")
include("receiver_2D.jl")
include("afd_2D_b.jl");


 nx = 500
 nz = 500
 nt =1500
 dx = 10.0
 dz = 10.0
 dt = .002
 npad = 90 
 f0 = 10.0
 c0 = 1700.0*ones(nx,nz) 

 c = 1700.0*ones(nx,nz)
  c[:,201:300].=2000.0
  c[:,301:end].=1400.0


I = zeros(nx,nz);
 is = 4
 is_x = 90+(is-1)*20
 filename = "shot_"*string(is)*".bin"
 fid = open(filename,"r");
 data = zeros(Float64,nx*nt);
 read!(fid,data);
 close(fid)

 data = reshape(data,nx,nt);


        s = source_2D(nx, nz, nt, dt, f0, is_x, 92)
   u,a,d  = afd_2D(nx, nz, nt, dx, dz, dt, c , npad, s, 92) # Source wavefield  u(x,z,t)

       sd = receiver_2D(nx,nz,nt,dt, data,92)   
        v = afd_2D_b(nx, nz, nt, dx, dz, dt, c , npad, sd)  # Receiver wavefeild v(x,z,t)

   I=dropdims(sum(v.*u,dims=3),dims=3)




