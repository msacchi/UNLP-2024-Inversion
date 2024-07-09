using SeisProcessing 
include("lib.jl");

nx =480; nz =222; nt =505; dx = 10.0; dz = 6.0; dt = .002;

npad = 20

 c = 2000*ones(nx,nz);

m1 = randn(nx,nz,nt);
d2 = randn(nx,nz,nt);


d1 = afd_2D_f(nx,nz,nt,dx,dz,dt,c,npad,m1)
m2 = afd_2D_b(nx,nz,nt,dx,dz,dt,c,npad,d2);

dot1 = sum(d1.*d2)
dot2 = sum(m1.*m2)

println(dot1,"  ",dot2, "  ", abs(dot1-dot2)/abs(dot1+dot2))
