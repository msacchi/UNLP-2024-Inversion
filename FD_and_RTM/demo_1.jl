using SeisProcessing
using SeisMakie, CairoMakie
using PyPlot 

# ----------------------------------------------
# demo_1.jl compute wavefield for one shot 
# ----------------------------------------------

 include("lib.jl")
 include("rtm_p.jl") 

 nx = 500
 nz = 500
 nt = 1600
 dx = 10.0
 dz = 10.0
 dt = .002
 npad = 80 
 f0 = 10.0
 ix_s = 250  
 iz_s = 91

c0,c = make_velo(nx,nz)

 ix_r = collect(1:5:nx); nr =  length(ix_r); 
 iz_r = ones(Int32,nr)*91


  s  = source_2D(nx, nz, nt, dt, f0, ix_s, iz_s)
  u  =    afd_2D(nx, nz, nt, dx, dz, dt, c , npad, s, ix_r,iz_r)[2]

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

