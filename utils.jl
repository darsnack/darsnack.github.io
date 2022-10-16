using Dates

"""
    {{recentarticles}}

Input the 3 latest articles.
"""
function hfun_recentarticles()
    curyear = Dates.Year(Dates.today()).value
    ntofind = 3
    nfound  = 0
    recent  = Pair{String,Date}[]
    for year in curyear:-1:2019
        for month in 12:-1:1
            ms = "0"^(1-div(month, 10)) * "$month"
            base = joinpath("articles", "$year", "$ms")
            isdir(base) || continue
            posts = filter!(p -> endswith(p, ".md"), readdir(base))
            days  = zeros(Int, length(posts))
            surls = Vector{String}(undef, length(posts))
            for (i, post) in enumerate(posts)
                ps       = splitext(post)[1]
                surl     = "articles/$year/$ms/$ps"
                surls[i] = surl
                pubdate  = pagevar(surl, :published)
                days[i]  = isnothing(pubdate) ?
                                1 : day(Date(pubdate, dateformat"d U Y"))
            end
            # go over month post in antichronological orders
            sp = sortperm(days, rev=true)
            for (i, surl) in enumerate(surls[sp])
                push!(recent, surl => Date(year, month, days[sp[i]]))
                nfound += 1
                nfound == ntofind && break
            end
            nfound == ntofind && break
        end
        nfound == ntofind && break
    end
    #
    io = IOBuffer()
    for (i, (surl, date)) in enumerate(recent)
        class = (i == length(recent)) ? "article-blurb" : "article-blurb notlast"
        url   = "/$surl/"
        title = pagevar(surl, :title)
        sdate = "$(day(date)) $(monthname(date)) $(year(date))"
        blurb = pagevar(surl, :desc)
        write(io, """
            <div class="$class">
              <h3><a href="$url">$title</a></h3><div class="date">$date</div>
              <p class="desc">$blurb</p>
            </div>
            """)
    end
    return String(take!(io))
end

"""
    {{articles}}

Plug in the list of articles contained in the `/articles/` folder.
"""
function hfun_articles()
    curyear = Dates.Year(Dates.today()).value
    io = IOBuffer()
    printyear = true
    for year in curyear:-1:2019
        ys = "$year"
        for month in 12:-1:1
            ms = "0"^(1-div(month, 10)) * "$month"
            base = joinpath("articles", ys, ms)
            isdir(base) || continue
            posts = filter!(p -> endswith(p, ".md"), readdir(base))
            days  = zeros(Int, length(posts))
            lines = Vector{String}(undef, length(posts))
            for (i, post) in enumerate(posts)
                if printyear
                    year < curyear && write(io, "\n**$year**\n")
                    printyear = false
                end
                ps  = splitext(post)[1]
                url = "/articles/$ys/$ms/$ps/"
                surl = strip(url, '/')
                title = pagevar(surl, :title)
                pubdate = pagevar(surl, :published)
                if isnothing(pubdate)
                    date    = "$ys-$ms-01"
                    days[i] = 1
                else
                    date    = Date(pubdate, dateformat"d U Y")
                    days[i] = day(date)
                end
                lines[i] = "\n[**$title**]($url) _$(date)_ \n"
            end
            # sort by day
            foreach(line -> write(io, line), lines[sortperm(days, rev=true)])
        end
        printyear = true
    end
    # markdown conversion adds `<p>` beginning and end but
    # we want to  avoid this to avoid an empty separator
    r = Franklin.fd2html(String(take!(io)), internal=true)
    startswith(r, "<p>")    && (r = chop(r, head=3))
    endswith(r,   "</p>")   && return chop(r, tail=4)
    endswith(r,   "</p>\n") && return chop(r, tail=5)
    return r
end
