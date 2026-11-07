\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{inseePremiere}[1995/04/01 The Simple News newsletter class]
\RequirePackage[usenames, dvipsnames]{color}
\RequirePackage[bidi=default]{babel}
\newcommand{\mycolor}{\color{RubineRed}}
%\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[twocolumn]{article}
\RequirePackage{ucs}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lettrine}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
%\RequirePackage{xstring}
%\RequirePackage{float}
%\RequirePackage{colortbl}
% \DeclareOption{green}{\renewcommand{\headlinecolor}{\color{green}}}
%\RequirePackage{color}
%\RequirePackage{booktabs}
%\RequirePackage{lipsum}
%\RequirePackage{layouts}

%% \newcommand{\cours}[1]{#1}
%% \newcommand{\bandeau}[1]{
%%   {\centering \fontsize{18mm}{20mm}\usefont{T1}{futs}{b}{n} #1}

%%   \begin{tabular}{lcr}
%% \includegraphics[width=0.2\textwidth]{fde}
%%   & \includegraphics[width=0.5\textwidth]{ur.jpg} 
%%   & \raisebox{10ex}{\bf \begin{tabular}{l} {\Large No 1613} \\ \today\\\end{tabular}}\\
%%   \end{tabular}
%% }
%% \renewcommand{\maketitle}{%
%%   \twocolumn[%
%%   \bandeau{Logiciels Statistiques}
%%   \vspace{1cm}

%%   {\fontsize{10mm}{12mm}\usefont{T1}{futs}{n}{n} \noindent \@title}

%%   \vspace{1cm}
%% ]%
%% }

\renewcommand{\maketitle}{%
  \twocolumn[%
  {\noindent \Huge \@title}

  \vspace{1cm}
]%
}


\renewcommand{\section}{%
\@startsection
{section}{1}{0pt}{-1.5ex plus -1ex minus -.2ex}%
{1ex plus .2ex}{\flushleft\large\sffamily\mycolor}%
}
\renewcommand{\subsection}{%
\@startsection
{subsection}{1}{0pt}{-1.5ex plus -1ex minus -.2ex}%
{1ex plus .2ex}{\flushleft\normalsize\sffamily}%
}

\setcounter{secnumdepth}{0}
\renewcommand{\normalsize}{\fontsize{9}{10}\selectfont}
\RequirePackage{multicol}
\RequirePackage{geometry}
\geometry{paperwidth=21cm, paperheight=29.7cm, width=18.2cm,
  height=25.2cm, left=2.2cm, top = 2.3cm}%,  bottom=2cm}
\normalsize
% \setlength\textwidth{18.2cm}
% \setlength\textheight{25.2cm}
% \setlength\paperwidth{21.0cm}
% \setlength\paperheight{29.7cm}
% \setlength\oddsidemargin{2.2cm}
% \setlength\headheight{0cm}
% \setlength\headsep{0cm}
% \setlength\footskip{0cm}
% \setlength\marginparwidth{0cm}
% \setlength\topmargin{2.3cm}
% \setlength\hoffset{-1.1in}
% \setlength\voffset{-1.1in}

\usepackage[]{mdframed}
\newmdenv[
        topline=false,
        bottomline=false,
        rightline=false,
        linewidth=4pt,
        innerleftmargin=15pt,
        leftmargin=0pt,
        rightmargin=0pt,
        innerbottommargin=0pt,
        linecolor=RubineRed
]{separator}

%\renewcommand{\includegraphics}[1]{\includegraphics[width=.5\textwidth]{#1}}

% \renewenvironment{abstract}[3]{\begin{separator} \lettrine[lines=3, loversize=-0.1,lraise=0.1,lhang=.2]{\textcolor{RubineRed}#2}{#3}
%     \newcommand{\foot}{#1}}{\vspace{.1cm} \hrule \vspace{.1cm} \noindent\foot \end{separator}}

%% \renewenvironment{abstract}[3]{\begin{separator} \lettrine[lines=3, loversize=-0.1,lraise=0.1,lhang=.2]{\textcolor{RubineRed}#2}{#3}
%%     \newcommand{\foot}{#1}}{\vspace{.1cm} \hrule
%%     \vspace{.1cm} \noindent\foot \end{separator}}

\renewenvironment{abstract}{\begin{separator} \lettrine[lines=5,
      loversize=-0.1,lraise=0.1,lhang=.2]}{\end{separator}}


%\renewenvironment{figure}{\begin{figure*}}{\end{figure*}}

%\setlength\textheight{\baselineskip*69+\topskip}
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}
