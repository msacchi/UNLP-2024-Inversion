"""
    make_velo(nx,nz)

Make a simple velocity model of size nx x nz

"""
function make_velo(nx,nz) 

  c0 = 1700.0*ones(nx,nz)
  c  = 1700.0*ones(nx,nz)
  c[:,201:300].= 2000.0
  c[:,301:end].= 2300.0

 return c0,c
end
