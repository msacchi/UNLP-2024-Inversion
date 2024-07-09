using SeisProcessing
using PyPlot

include("lib.jl")  


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
 

 is = 10 
        is_x = 90+(is-1)*20
        s = source_2D(nx, nz, nt, dt, f0, is_x, 92)
   u,a,d  = afd_2D(nx, nz, nt, dx, dz, dt, c , npad, s, 92) 
 u0,a,d0  = afd_2D(nx, nz, nt, dx, dz, dt, c0, npad, s, 92) 
     data = d-d0 
 filename = "shot_"*string(is)*".bin"
 fid = open(filename,"w");
 write(fid,data[:])
 close(fid)

