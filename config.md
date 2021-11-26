<!--
Add here global page variables to use throughout your
website.
The website_* must be defined for the RSS to work
-->
@def website_title = "Kyle Daruwalla"
@def website_descr = "My personal website"
@def website_url   = "https://darsnack.github.io"

@def author = "Kyle Daruwalla"

@def mintoclevel = 2

<!--
Add here files or directories that should be ignored by Franklin, otherwise
these files might be copied and, if markdown, processed by Franklin which
you might not want. Indicate directories by ending the name with a `/`.
-->
@def ignore = ["node_modules/", "franklin", "franklin.pub"]

<!--
Add here global latex commands to use throughout your
pages. It can be math commands but does not need to be.
For instance:
* \newcommand{\phrase}{This is a long phrase to copy.}
-->
\newcommand{\set}[1]{ \mathbb{#1} }
\newcommand{\vecb}[1]{ \mathbf{#1} }
