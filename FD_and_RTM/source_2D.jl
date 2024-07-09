"""
    source_2D(nx, nz, nt, dt, f0, ix_s, iz_s)

Source (right hand side term) for wave equation simulation 

# Arguments
- `nx`: number of grid points x
- `nz`: number of grid points z
- `nt`: number of time steps
- `dt`: number of time steps [seconds]
- `f0`: central frequency of min phase Ricker wavelet
- `ix_s`: source x grid index position  
- `iz_s`: source z grid index position 
# Output
- `source`: source term of size nx x nz x nt. This is the source injected by `afd_2D.jl` and `afd_2D_f.jl`
# Note
- The injected wavelet is from the `SeisProcessing.jl` package. The wavelet is a zero-phase Ricker
wavelet converted to minumum phase via Kolmogoroff factorization. 

*Credits: MDS 2024*

"""
function source_2D(nx, nz, nt, dt, f0, ix_s, iz_s) 

 w = SeisKolmogoroff(Ricker(dt=dt,f0=f0))  # wavelet to inject is a Ricker turned into min phase

 source = zeros(nx,nz,nt) 

   for n = 1:length(w)
    source[ix_s,iz_s,n] = w[n]
   end

  return source
 end 
 


