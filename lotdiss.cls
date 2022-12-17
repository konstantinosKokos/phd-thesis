%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lotdiss}[2018/02/11 LOT dissertation class]

% LOT dissertation class. 

% This LaTeX class is intended to satisfy the formatting requirements of 
% the Landelijke Onderzoekschool Taalwetenschap (LOT), the Dutch National
% Graduate School in Linguistics.
% There are (or will be) class options for the different LOT member institutes

% Alexis Dimitriadis 2011-2018
%
% This style comes with an associated example file, lotdiss-template.tex.
%
% Use: \documentclass[<institute>]{lotdiss}
% Options: 
%   Accepts all book class options, and the following additional ones:
%
%   utrecht, leiden, nijmegen, aclc, groningen:    These tailor the 
%       style to the corresponding LOT member institute
%
%   [preview]  Change the paper size to the true LOT book size (24x16cm).
%       Only works properly with pdf output.
%       This is not the default because it can cause printing problems, and
%       IS NOT NECESSARY: The printers expect A4 pages and will do the rest.
%
%   [notitlesec]  Do not override the format of chapter and section 
%       titles with the package titlesec. Use this if you prefer the
%       original latex style, or to customize with a different package.
%       I don't recommend this: Use titlesec commands in your preamble
%       to customize chapter and section titles to your taste.

% REVISION HISTORY
%
% 2018/02/11 v. 1.4b  Added \support{ } macro, which adds funding information to the 
%                     promotors page per current LOT recommendation.
%
% 2018/01/12 v. 1.4  Updated Groningen style (significant changes, since 2015)
%
% 2018/01/11 v. 1.3e  Fixed occasional bugs with running heads: in
%                     appendices, after \hidefromtoc.
%
% 2017/09/26 v. 1.3d  Updated LOT phone number, ACLC rector magnificus.
%
% 2014/02/12 v. 1.3c Increased the top margin to 5.8cm, as per new LOT style.
%
% 2013/08/13 v. 1.3b  Changes to the LOT and Utrecht details. Inconsequential 
%                     change to the page size computation.
%
% 2012/09/25 v. 1.3   Page height is set to exactly fit a (maximal) number of 
%                     lines, avoiding ugly gaps in text-only pages. 
%                     Fixed bug in the index ``improvements''.
%
% 2011/08/17 v. 1.2   \chapter* now resets all counters that \chapter would.
%                     Three columns now allowed in Promotor page (for ":")
%
% 2011/01/28 v. 1.1b  Replaced fncychap with titlesec. Added [preview] option.
%                     Corrected spacing for groningen style.
%
% 2011/01/23 v. 1.0   First distributable version. 



% Retire the [(no)titlepage] option
\def\title@off{\message{Class lotdiss Warning: The [(no)titlepage] option has been disabled. ^^J
To suppress the title page and other front matter, comment out the command^^J
\@backslashchar FrontMatter in your document}}

\DeclareOption{titlepage}{\title@off}
\DeclareOption{notitlepage}{\title@off}
% (Restore if it causes any problems)
%\PassOptionsToClass{notitlepage}{book}

\def\@lotschool{utrecht} % Default

\DeclareOption{leiden}{\let\@lotschool=\CurrentOption}
\DeclareOption{utrecht}{\let\@lotschool=\CurrentOption}
\DeclareOption{nijmegen}{\let\@lotschool=\CurrentOption}
\DeclareOption{aclc}{\let\@lotschool=\CurrentOption}
\DeclareOption{groningen}{\let\@lotschool=\CurrentOption}

% [notitlesec]: Don't load titlesec.sty package.
%    User must deal with restyling manually.
\newif\iflotdiss@restyle \lotdiss@restyletrue
\DeclareOption{notitlesec}{\lotdiss@restylefalse}

% [preview]: Set media dimensions to the true LOT book size (16x24cm).
%    Only works with pdf.
\newif\iflotdiss@preview \lotdiss@previewfalse
\DeclareOption{preview}{\lotdiss@previewtrue}

% Pass any other options to the parent class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions 

% Start up the book class, which lotdiss.cls adds to.
% Options declared to \PassOptionsToClass above are silently passed on.
\LoadClass[a4paper]{book}

\frenchspacing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%           START OF CUSTOMIZABLE SECTION
%
% Redefining or overriding these settings should allow adaptation of
% this style file to other dissertation specifications.
%

%***************PAGE DIMENSIONS**********************

% The book will be printed on paper 16 x 24 cm. We normally don't declare this,
% to prevent problems with printers who may refuse to print on A4
% To generate pdf with the right media size, use the [preview] class option (below).
%
% A4 paper is 210 x 297 mm.
% All text must appear in a block 12 x 20 cm. 
% We center this block in the A4 page (the printshop will trim it for the book)

% To avoid ugly gaps when there's only text on a page, \textheight must 
% exactly fit some number of text lines.
% The first line normally takes up \topskip; the rest take \baselineskip
% We round the height *down* (bk12.clo etc. might round up as well):
\def\UseTextheight#1{
  \textheight=#1
  % subtract the space of the running heads (we use no footer)
  \advance\textheight by -\headheight
  \advance\textheight by -\headsep
  % Now round down, properly
  \@tempdima = \textheight
  \advance\@tempdima by -\topskip  % the top line is shorter
  \divide\@tempdima\baselineskip
  \@tempcnta=\@tempdima
  \setlength\textheight{\@tempcnta\baselineskip}
  \addtolength\textheight{\topskip}}  % add the top line back

% The default \headheight is suitable for 10pt text; At 11pt, fancyhdr
% issues a warning and adjusts it. So we fix it in time for the page size
% calculations.
\headheight=\baselineskip 

% Text dimensions: 12 x 20cm, including the running heads. 
\textwidth=12cm
\UseTextheight{20cm}   %  Use the full height available. (20cm = 569.055pt)

% The results:
% at [10pt]: 538pt   (45 lines)
% at [11pt]: 527.8pt (39 lines)
% at [12pt]: 534pt   (37 lines)


% Left/right margins = (210-120)/2 = 4.5 cm
\oddsidemargin=4.5cm \advance\oddsidemargin by -1in % Correct by TeX's "zero" margin
\evensidemargin=\oddsidemargin

% Top margin: 5.8cm
\topmargin=5.8cm \advance\topmargin by -1in % Correct by TeX's "zero" margin


% But if the [preview] option was given, override the above margins:
\RequirePackage{ifpdf}

\iflotdiss@preview
% Preview what it will look like in the real booklet (we only support pdf)

  % The paper dimensions are only effective if we're generating PDF
  \ifpdf
    \pdfpagewidth=16cm
    \pdfpageheight=24cm
  \fi

  % Text is 12x20cm, so we have 2cm margins all around
  \oddsidemargin=2cm \advance\oddsidemargin by -1in % Correct by "zero" margin
  \evensidemargin=\oddsidemargin
  \topmargin=2cm \advance\topmargin by -1in % Correct by TeX's "zero" margin
\fi % End of preview mode



%=========


% Running heads from Mark
%***************FANCY HEADERS**********************
\usepackage{fancyhdr}

% This doesn't seem to work as advertized: It wipes out
% the fancyhdr settings i've selected, unless i store them in {lotpage}
%
% The ``plain'' page style is activated on chapter title pages by default.
% We actually want it to be completely empty:
\fancypagestyle{plain}{\fancyhf{}\renewcommand\headrulewidth{0pt}}

\fancypagestyle{lotpage}{%
  \fancyhf{}% start on a clean slate: clear all fields
  \renewcommand\headrulewidth{0pt} 
  \fancyhead[LE,RO]{\textrm{\thepage}}
  \fancyhead[LO]{\nouppercase{\textbf{\strut\leftmark}}}
  \fancyhead[RE]{\nouppercase{\textbf{\strut\rightmark}}}}

% Actual plain style: Just the page number
\fancypagestyle{realplain}{%	
  	\fancyhf{} % start with a clean slate: clear all fields
    \renewcommand\headrulewidth{0pt}
    \fancyhead[LE,RO]{\textrm{\thepage}}
  }
  
\pagestyle{lotpage} % In case we never call \FrontMatter or \MainMatter

% Commands to set the running head. Called by \chapter and \section. 
% The actual defaults include \MakeUppercase, but fancyhdr disables it.

% The default for \chaptermark is \markboth{#1}{}; but if we don't use 
% \section for a couple of pages, we end up with no header on the even
% page. So, we set it to ``Chapter N'' (or ``Appendix N'') as a fall-back
\renewcommand{\chaptermark}[1]{\markboth{#1}{\@chapapp\ \thechapter}}
% This works fine as it is
%\renewcommand{\sectionmark}[1]{\markright{#1}}

%%%%%%%%%%%%%%%%%%%%
% Fix package interactions that mess up the page headings

% These settings must be delayed until after the author includes the relevant
% packages. The result is that we then override the author's attempts to
% redefine the same command in the preamble! Oh well, you can't have
% everything... Authors must use \AtBeginDocument as well.

% Endnotes.sty tries to mark both even and odd pages with \notesname.
% Let's treat it like any other section:
\AtBeginDocument{\def\enoteheading{\section*{\notesname\addcontentsline{toc}{section}{\notesname}}\markright{\notesname}%
  \mbox{}\par\vskip-\baselineskip}}

% The above is for endnotes at the end of each chapter.
% Endnotes for the entire book should use \chapter* instead of 
% \section* in the above definition (but then mark both sides); it's not the
% default since chapter-by-chapter endnotes are less cumbersome.

% Obsolete bugfix: natbib causes running heads to be capitalized; the new
% "lotpage" pagestyle suppresses this-- no need to override them.

% Tweaks for gb4e: Make example numbering chapter-internal, enable italic numbering in footnotes

\AtBeginDocument{\@ifpackageloaded{gb4e}
    {% Style footnote examples like this: (i) Example. (The parens are baked into \@exe)
     \long\def\@footnotetext#1{{%
        \@noftnotefalse\setcounter{fnx}{0}\def\@@xsi{\let\@xsi\roman}%
        \@gbsaved@footnotetext{#1}}}%
      % Reset example numbers at each chapter. 
      \@addtoreset{exx}{chapter}%
        }{}% If gb4e was not loaded, do nothing
} 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         Definitions of front matter contents

% Front matter elements are defined in the preamble and assembled in
% the proper order by \FrontMatter.

% The following commands should be used in the preamble to provide the
% appropriate text or \input commands.  Some are optional; if not sure,
% you can always just try leaving them out. The style will complain if they
% are obligatory!

% General 

% \author and \title are already defined in latex
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\dutchtitle#1{\gdef\@dutchtitle{#1}} 		
\def\dutchsubtitle#1{\gdef\@dutchsubtitle{#1}}

% LOT publication page
\long\def\abovepublisher#1{\gdef\@abovepublisher{#1}} \abovepublisher{\relax}
\long\def\imagecredit#1{\gdef\@imagecredit{#1}}		\imagecredit{\relax}
\def\isbn#1{\gdef\@isbn{#1}} 
\def\NUR#1{\gdef\@nurnumber{#1}}

\def\copyrightyear#1{\gdef\@copyrightyear{#1}}  
\copyrightyear{\number\year}         % may be overridden in the document

\def\copyrightclaim#1{\gdef\@copyrightclaim{#1}}
\copyrightclaim{Copyright \copyright\ \@copyrightyear\ \@author. All rights reserved.}

% Main title page
\def\proefschrifttext#1{\gdef\@proefschrifttext{#1}}
\def\rectormagnificus#1{\gdef\@rectormagnificus{#1}}
\def\promotiondate#1{\gdef\@promotiondate{#1}}		\promotiondate{}

\def\geboren#1{\gdef\@geboren{#1}}

% Promotors page
\def\promotores#1{\gdef\@promotores{#1}}
\let\promotors=\promotores

% Optional statement of support
\long\def\support#1{\gdef\@support{#1}}

% Contrive to \include a file without starting a new page (by temporarily
% disabling \clearpage).  A new page is still begun at the end of the include.
\def\@includehere#1{\bgroup\let\clearpage=\egroup\include{#1}}

% This entirely disables page breaks from \include and \chapter; \newpage
% can still be called.
%
%\def\CvPageFile#1{\cleardoublepage
%  \bgroup\let\clearpage=\relax\include{#1}\egroup }


% Example: \dedication{blah, blah} OR \dedicationfile{Dedication}
%
% The dedication is vertically centered on the page, and otherwise
% formatted by the author
\long\def\dedication#1{%
    \long\def\@dedication{{\null\vfil\parindent=0pt\relax #1\par\vfil\null}}}

\def\dedicationfile#1{\dedication{\@includehere{#1}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The format and order of the preliminary pages.
% Optional pages are only created if requested.
% List of Figures and List of Tables pages are only created if there are
% figures or tables. 
% Syntax: 
%    \FrontMatter 
%    \include{Acknowledgments} % etc.
%    \MainMatter
%
\def\FrontMatter{%
  \pagenumbering{roman}\pagestyle{realplain}%
  
  % Most of these call \cleardoublepage
  \HalfTitlePage
  	\newpage 
  \LOTpage 
	\newpage
  \TitlePage
  	\newpage
  \PromotorPage
  
  \cleardoublepage	
  \@ifundefined{@dedication} \relax
      {\thispagestyle{empty}\@dedication \let\@dedication=\@undefined}%
  \cleardoublepage

  % Our redefined \@schapter tries to add the TOC to the TOC.
  \hidefromtoc{\tableofcontents}%
  	
  \@ifundefined{pd@list@tables} \relax
      \listoftables
  \@ifundefined{pd@list@figures} \relax 
      \listoffigures
}

% Start the regularly-numbered part of the dissertation.  
% We might want to extend what these do
\def\MainMatter{\mainmatter\pagestyle{lotpage}}

\def\BackMatter{\backmatter 
	\addtocontents{toc}{\protect\vskip 0.5em \relax}} 
% We separate last chapter TOC from back materials.
% This amount plus the skip in l@schapter (defined below) should equal 1.0em, the skip in l@chapter.


% Definitions of the frontmatter pages. This is all modular so that the parts 
% can be redefined as necessary.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Initial empty page with just the title (``half-title'' or ``bastard-title'')
%
\newcommand\HalfTitlePage{%
	\cleardoublepage
	\thispagestyle{empty}
	\begin{center}
    
  \null\vfill

  % TODO: There MUST be a way for \ShowTitle to detect if it is passed
  % an empty \@subtitle macro!
  %
  \@ifundefined{@subtitle}
	{\ShowTitle{\@title}{}}
	{\ShowTitle{\@title}{\@subtitle}}
  
  \vfill\vfill\null
\end{center} }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Verso page with the LOT information and copyright notice
%
\newcommand\LOTpage{\bgroup
	\parindent=0pt
	\thispagestyle{empty}%

	% Set text flush with the bottom of the page
	\null \vfill

\@ifundefined{@abovepublisher} \relax
	{\@abovepublisher \bigskip }
	
Published by \\[4pt]
LOT  		\hfill	phone: +31 30 253 6111  \\
Trans 10    	\hfill 	e-mail: lot@uu.nl  \\
3512 JK Utrecht  	\hfill	http://www.lotschool.nl \\
The Netherlands 	\hfill	

\bigskip\bigskip
\@ifundefined{@imagecredit} \relax
	{\@imagecredit \bigskip }
	
ISBN: \@isbn \\
NUR: \@nurnumber

\bigskip
\@copyrightclaim

\egroup}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title page
%
% Elastic space at the top (but Groningen has special needs)
\def\lotd@tp@topstuff{\null\vfill}
% Groningen & Nijmegen will override this
\def\lotd@tp@aftertitle{\bigskip \vfill}

\newcommand\TitlePage{%
  \newpage \begin{samepage}\thispagestyle{empty}\center
  \parindent=0pt
  \parsep=0pt
  
  \lotd@tp@topstuff
  
  \@ifundefined{@subtitle}
	{\ShowTitle{\@title}{}}
	{\ShowTitle{\@title}{\@subtitle}}

  \bigskip \vskip 0pt minus 6pt % Squeeze a little if we're tight

  \@ifundefined{@dutchtitle} \relax
	{\bigskip
	 \@ifundefined{@dutchsubtitle}
		{\ShowTitle{\@dutchtitle}{}}
		{\ShowTitle{\@dutchtitle}{\@dutchsubtitle}}
	{\Large \vskip \baselineskip {\large (met een samenvatting in het Nederlands)}}}
	
  \lotd@tp@aftertitle
	
{\Large \proefschrift@name}\\[0.5cm]

	\@proefschrifttext
	\bigskip

door

\vspace{3ex}
{\Large \@author}

\vspace{2ex}

geboren \@geboren 
\vfill\null
\end{samepage}\newpage }
% End of title page

% Utility command used in both title pages:
% Format a title and subtitle (if any)
\newcommand\ShowTitle[2]{\bgroup
	\def\baselinestretch{\TitleStretch}%
	\par
	\TitleSize{#1}\par
	{\def\@subt{#2}%
	  \ifx\@subt\@empty   % (empty) % debug
      \else
      	% provide linespacing appropriate for the (larger) \TitleSize
		\vskip\baselineskip \SubtitleSize \vskip-\baselineskip 
		#2\par 
	  \fi
	}%
\egroup }

\def\proefschrift@name{\Large Proefschrift}  % For everyone but ACLC

\let\TitleSize=\huge
\let\SubtitleSize=\LARGE
\def\TitleStretch{1.4}


\newcommand\PromotorPage{\bgroup
\newpage\thispagestyle{empty}\parindent=0pt
\normalsize

\begin{tabular}{lll}
	\@promotores
\end{tabular}

\@ifundefined{@support} \relax
{\par\vfill
\@support
}%
\egroup}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load titlesec unless the user suppressed it with [notitlesec]
\iflotdiss@restyle
  \RequirePackage{titlesec}
  
  \titleformat{\chapter}[display] 
    {\Large}% General format
    {\filleft\MakeUppercase{\chaptertitlename} \Huge\thechapter}% Chapter N
    {52pt} % Space between label and title
    {\titlerule[0.5pt] \vspace{1.75ex} \filleft\strut} % Before title body 
    [\vspace{2.2ex}{\titlerule[0.5pt]}] % After title body

  % \titlespacing*{left}{above}{below}[right] ; * = \noindent next par
  \titlespacing*{\chapter}{0pt}{58pt}{40pt}

  % Extra space below title for \chapter* (incl. TOC, References)
  \titlespacing*{name=\chapter,numberless}{0pt}{58pt}{64pt}
  
  % Finetune sections too?
\else
  \message{^^JPackage titlesec: Loading suppressed by class option [notitlesec]^^J}
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                  END OF CUSTOMIZABLE SECTION
%
%  LaTeX magic beyond this point-- Use extreme care if you have to
%  make changes!
%

% Keep a record of whether there were figures and tables
\let\lot@svd@caption=\caption
\def\caption
  {\expandafter\gdef\csname pd@have\@captype s\endcsname{1} \lot@svd@caption}

% The following code (standard latex) appends; I needed to prepend,
% otherwise the implicit argument of \caption (the name of figure or 
% table) is lost!
%% (no \protect needed when defining directly)
%\g@addto@macro\caption
%  {\protect\expandafter\gdef\csname pd@have\@captype s\endcsname{1}}

% Save a *different* flag in .aux (so it can turn off if the tables go away).
\AtEndDocument{
  \@ifundefined{pd@havetables} \relax
     {\immediate\write\@mainaux{\string\gdef\string\pd@list@tables{1}}}
  \@ifundefined{pd@havefigures} \relax
     {\immediate\write\@mainaux{\string\gdef\string\pd@list@figures{1}}}}


% Start a section in the front matter, adding it to the TOC
% Syntax: \PreSection[TOC title]{Actual title}
%
\def\PreSection{\chapter*}
% (This is trivial thanks to the following modification to default LaTeX
% behavior: 


% Modify the handler for \chapter* so that the title is automatically added 
% to the toc. Must be called after we've customized \@schapter .
% This also extends the \chapter[TOCtitle]{actual title} syntax to \chapter*.
%
% Instead of relying on the style for chapter titles, we define below a
% special style for such TOC entries: l@schapter (triggered by specifying
% style {schapter} to \addcontentsline).

\AtBeginDocument{
  \let\orig@@schapter=\@schapter
  % If no optional argument in [ ] follows, \@dblarg copies the normal title
  \def\@schapter{\@dblarg{\lot@schapter}}
  \def\lot@schapter[#1]#2{\addcontentsline{toc}{schapter}{#1}  
  \@mkboth{#1}{#1}
  % advance, revert the chapter counter to zero any counters within it
  % (\stepcounter triggers the auto-reset. \addtocounter does not.)
  \stepcounter{chapter}\addtocounter{chapter}{-1} 
  \orig@@schapter{#2}}}


% TOC line style: Dotted line, not bold, flush left. 
%    Less space between entries than the 1.0em used above chapter heads
\newcommand*\l@schapter[2]{%
    % Skip and add a suitable penalty, but only if the page number will be displayed.
    \ifnum \c@tocdepth >\m@ne
      \addpenalty{-\@highpenalty}% ok to break here
      \vskip 0.5em \@plus\p@
    \fi
    \@dottedtocline{1}{0pt}{1.5em}{#1}{#2}}
%   Syntax: \@dottedtocline{numbering level}{left indent}{hanging indent} {text}{page}


% If you need to call a \chapter* (or any other section level) without
% making an entry in the TOC, do it like this:
%   \hidefromtoc{\chapter*{Non-TOC title}}
\def\hidefromtoc#1{{\renewcommand\addcontentsline[3]{\relax}\let\phantomsection=\relax #1}}

% STILL WANTED: A way to put the full chapter title in the TOC (but without 
% any fragile commads or footnotes), but a short title in the header.
% The right behaviour: Really the TOC should use the full title by
% default. (The TOC macros already disable indexing commands and the like).
% There's a package somewhere that fixes this...

% Redefined to ensure that an extra blank page is completely blank
\let\ldiss@svcldoub=\cleardoublepage
\def\cleardoublepage{\clearpage\ifodd \c@page\else \thispagestyle{empty}\fi \ldiss@svcldoub}


%% Better index support

\RequirePackage{makeidx}
% We won't call this automatically until we have a way to disable it
%\makeindex

% These were all defined in book.cls, hence could be redefined even if we don't load makeidx.sty:

% Redefine the index environment, which is a disaster. Our version calls \chapter*, ensuring
% that it will behave like other unnumbered chapters (start on odd page, add to TOC, provide
% a consistent amount of whitespace at the top of the page).
%
\renewenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
%                \twocolumn[\@makeschapterhead{\indexname}]%
% Replaced by the following 2 lines:
				\cleardoublepage 
				\twocolumn\chapter*{\indexname}%	
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}

%% Adjust indentation so that page ranges are more likely to fit well in the LOT page width.
\renewcommand\@idxitem{\par\hangindent 30\p@}
\renewcommand\subitem{\@idxitem \hspace*{15\p@}}
\renewcommand\subsubitem{\@idxitem \hspace*{22.5\p@}} % 3/4 of 30pt (same as the default proportion)


%% Load school-specific definitions and texts

\input{\@lotschool.clo}

\endinput

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	   END OF THE LOTDISS.CLS STYLE

