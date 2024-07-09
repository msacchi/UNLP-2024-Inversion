	"""
    read_bin(filename,nr,nt)

# Arguments
- `filename`: name of binary file containing shot gather
- `nr`: number of receivers
- `nt`: number of time samples
# Output
- `data:` data matrix size nr x nt

*Credits: MDS 2024*

"""
 function read_bin(filename,nr,nt)

  fid = open(filename,"r");
  data = zeros(Float64,nr*nt);
  read!(fid,data);
  close(fid)
  data = reshape(data,nr,nt);
return data
end
