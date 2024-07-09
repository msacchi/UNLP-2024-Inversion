"""
    afd_2D_f(nx,nz,nt,dx,dz,dt,c,npad,source)

Acoustic Finite Difference wave propagation in 2D media with ABC.
Program to compute the source-side wavefield for RTM.

# Arguments
- `nx`: number of grid points x
- `nz`: number of grid points z
- `nt`: number of time steps
- `dx`: x spatial grid sampling [meters]
- `dz`: x spatial grid sampling [meters]
- `dt`: number of time steps [seconds]
- `c`: media velocity as a matrix of size nx x nz [meters/seconds]  
- `npad`: number of grid points for absorbing area       
- `source`: cube of size nx x nz x nt with the source term 
# Output
- `u`: source-side wavefield of size nx x nz x nt

*Credits: MDS 2024*

"""
function afd_2D_f(nx,nz,nt,dx,dz,dt,c,npad,source) 

 nxp = 2*npad+nx
 nzp = 2*npad+nz

  A0 = (minimum(c)*dt)^2
  F = 1.0/A0+0.01

  amax = dt*(F-1.0/A0)

  a = damping_2D(nx,nz,npad; fact=amax, degree=2)
  m = 1.0./c.^2
  A1 = m/(dt*dt)
  A2 = a/dt
  A3 = A1+A2

 u = zeros(nx,nz,nt)
 source[:,:,1].=0.0

 for n = 2:nt-1
   for ix = 2:nx-1
     for iz = 2:nz-1
       Dxx  = (u[ix+1,iz,n] - 2*u[ix,iz,n] + u[ix-1,iz,n])/(dx*dx)
       Dzz  = (u[ix,iz+1,n] - 2*u[ix,iz,n] + u[ix,iz-1,n])/(dz*dz)
       L = Dxx + Dzz
       u[ix,iz,n+1] = (source[ix,iz,n]+L+A1[ix,iz]*(2*u[ix,iz,n]-u[ix,iz,n-1])+A2[ix,iz]*u[ix,iz,n])/A3[ix,iz]
      end
   end  
if isapprox(round(n /250) * 250, n) ;  println("Time step for source wavefield ", n); end

end

return u
end
