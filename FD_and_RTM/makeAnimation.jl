function makeAnimation(
        filename::String,
        A::AbstractArray{<:Real};
        pclip = 100,
        ox = 0,
        dx = 1,
        oy = 0,
        dy = 1,
        framerate::Integer=30
    )

    # Creating an variable that triggers a change in the figure after a change in its value
    iter = Observable(1)

    iterations = 1:size(A,3)

    fig = Figure()
    ax = Axis(fig[1,1], yreversed=true, xautolimitmargin=(0,0), yautolimitmargin=(0,0))

    # Creating a plot, it will change with the variable iter, this is done by the @lift macro
    img = @lift(seisimageplot!(ax, A[:,:,$iter],
                               pclip=pclip, ox=ox, dx=dx, oy=0, dy=1))

    record(fig, filename, iterations; framerate=framerate) do it
        # modifying the Observable variable to change the plot
        iter[] = it
    end

    return nothing
end
