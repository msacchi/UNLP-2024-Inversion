 include("damping_2D.jl")    # Damping function for ABCs
 include("source_2D.jl")     # RHS for forward operator 
 include("receiver_2D.jl")   # RHS for adjoint operator 
 include("afd_2D.jl")        # FD solution of the acoustic wave equation in 2D
 include("afd_2D_f.jl")      # Forward FD operator 
 include("afd_2D_b.jl")      # Adjoint FD operator 
 include("make_data.jl")     # Make shot gathers to test rtm.jl
 include("make_velo.jl")     # velocity model 
 include("rtm.jl")           # Reverse Time Migration (RTM) 
 include("read_bin.jl")      # read a shot gather 
 include("write_bin.jl")     # write a shot gather 


