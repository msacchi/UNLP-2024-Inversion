using SeisProcessing
using PyPlot

# ----------------------------------------------
# demo_2.jl is used to produce shot gathers 
# and then use them to image the subsuface
# via RTM (Reverse Time Migration)
# ----------------------------------------------

 include("lib.jl")

 nx = 500
 nz = 500
 nt = 1600
 dx = 10.0
 dz = 10.0
 dt = .002
 npad = 80 
 f0 = 10.0
 ix_s = collect(100:20:400)
 ns =  length(ix_s)
 iz_s = 81*ones(Int32,ns) 

 ix_r = collect(1:25:nx)
 nr = length(ix_r)
 iz_r = ones(Int32,nr)*95

 c0,c =  make_velo(nx,nz) 
   make_data(nx,nz,nt,dx,dz,dt,f0,c,c0,npad,ix_s,iz_s,ix_r,iz_r)

I = rtm(nx,nz,nt,dx,dz,dt,f0,c,c0,npad,ix_s,iz_s,ix_r,iz_r);


# -------- Figures ----------------

 close("all");

 figure(1,figsize = (7,10))

 data=read_bin("shot_1.bin",nr,nt)
 dmax = maximum(data) 
 imshow(data',extent=[1,nr,(nt-1)*dt,0],aspect=15,vmin=-dmax*0.7,vmax=dmax*0.7,cmap="seismic")
 xlabel("Receiver number");ylabel("Time [s]")
 savefig("data_16_shot_20_rec.png")


 figure(2,figsize = (7,10))

 imshow(I',extent=[0,(nx-1)*dx,(nz-1)*dz,0],aspect=0.5,vmin=-.8,vmax=.8,cmap="seismic")
 imshow(c',extent=[0,(nx-1)*dx,(nz-1)*dz,0],alpha=0.1)
 plot((ix_r.-1)*dx,(iz_r.-1)*dz,"v")
 plot((ix_s.-1)*dx,(iz_s.-1)*dz,"*k")
 xlabel("x [m]"); ylabel("z [m]")
 savefig("rtm_16_shot_20_rec.png")




