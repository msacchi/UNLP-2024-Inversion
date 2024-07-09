"""
    read_bin(filename,data)

# Arguments
- `filename`: name of binary file to write  shot gather
- `data`: shot gather nr x nt

*Credits: MDS 2024*

"""
 function write_bin(filename,data)

 fid = open(filename,"w");
 write(fid, data[:])
 close(fid)

return
end
