If you ever need to print out a hard copy of source code and the print function of your editor of choice just doesn't quite do it, or you want to add a nice header to the page, or you want to actually just place a source code file in a written document, here's a nice way using everyone's favorite: [LaTeX][].

tl;dr: use the [listings][] package and input your external code file with `\lstinputlisting`.

So here's the LaTeX code.
    
    #!latex
    % Declare page size and style.
    \documentclass[a4paper, 12pt]{article}
    
    % Declare which packages to use..
    \usepackage{listings}
    
    % Define 
    \lstset{
        % Define options for listings
        language=Python,
        % Show space characters.
        showspaces=false,
        % Show space characters in strings.
        showstringspaces=false,
        % Show tab characters.
        showtabs=false,
        % Break long lines that go off the page.
        breaklines=true,
        % Size of tabs.
        tabsize=2,
        % Place line numbers on left.
        numbers=left,
        % Place a frame around code.
        frame=single,
    }
    \begin{document}
    \lstinputlisting{models.py}
    \end{document}

Full options for `lstset` are in the [listings documentation][docs].

[docs]: http://mirrors.ctan.org/macros/latex/contrib/listings/listings.pdf
[LaTeX]: http://www.latex-project.org/ 'LaTeX rocks!'
[listings]: http://www.ctan.org/tex-archive/macros/latex/contrib/listings/
