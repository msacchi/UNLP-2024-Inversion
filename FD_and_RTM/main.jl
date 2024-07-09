using SeisProcessing
using PyPlot

include("damping_2D.jl")
include("source_2D.jl")
include("afd_2D.jl")
include("make_data.jl")

 nx = 500
 nz = 500
 nt =1600
 dx = 10.0
 dz = 10.0
 dt = .002
 npad = 90 
 f0 = 10.0
 c0 = 1700.0*ones(nx,nz) 

  c = 1700.0*ones(nx,nz) 
  c[:,250:290].=2000.0
  c[:,291:end].=1400.0

        s = source_2D(nx, nz, nt, dt, f0, 250, 92)
  u0,a,d  =    afd_2D(nx, nz, nt, dx, dz, dt, c , npad, s, 92) 
 u, a,d0  =    afd_2D(nx, nz, nt, dx, dz, dt, c0, npad, s, 92) 

 data = d-d0 




u = permutedims(u,[2,1,3]);
v = 0.1*maximum(u);
figure(figsize = (7,10))
subplot(321); imshow(u[:,:,200],vmin=-v,vmax=v;cmap="seismic")
              imshow(c',alpha=0.2)
              title("n=200") 

subplot(322); imshow(u[:,:,300],vmin=-v,vmax=v;cmap="seismic")
              imshow(c',alpha=0.2)
              title("n=300") 
subplot(323); imshow(u[:,:,400],vmin=-v,vmax=v;cmap="seismic")
              imshow(c',alpha=0.2)
              title("n=400") 
subplot(324); imshow(u[:,:,700],vmin=-v,vmax=v;cmap="seismic")
              imshow(c',alpha=0.2)
              title("n=700") 
subplot(325); imshow(u[:,:,800],vmin=-v,vmax=v;cmap="seismic")
              imshow(c',alpha=0.2)
              title("n=800") 
subplot(326); imshow(u[:,:,900],vmin=-v,vmax=v;cmap="seismic")
              imshow(c',alpha=0.2)
              title("n=900") 


tight_layout();

savefig("figure_ABC.png")


figure(figsize = (9,6))
subplot(121); imshow(c',alpha=0.9,cmap="PuOr");colorbar()
title("Velocity m/s")
subplot(122); imshow(a',alpha=0.9,cmap="PuOr");colorbar()
title("Damping")
tight_layout();
savefig("damping.png")



