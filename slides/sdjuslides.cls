%% 上海电机学院 毕业设计（论文）答辩幻灯片
%% 编译：latexmk slides.tex（XeLaTeX）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjuslides}[2026/11/21 v1.0 SDJU Defense Slides]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass[aspectratio=169,11pt]{beamer}
\RequirePackage{xeCJK}
\RequirePackage{booktabs}
\RequirePackage{tikz}
\RequirePackage{listings}

% 与论文模板使用相同的中文字体。投影正文默认无衬线。
\IfFontExistsTF{SimSun}
  {\setCJKmainfont{SimSun}[AutoFakeBold=2,AutoFakeSlant=.2]
   \setCJKmonofont{SimSun}}
  {\setCJKmainfont{FandolSong-Regular.otf}[BoldFont=FandolSong-Bold.otf]
   \setCJKmonofont{FandolFang-Regular.otf}}
\IfFontExistsTF{SimHei}
  {\setCJKsansfont{SimHei}[AutoFakeBold=2]}
  {\setCJKsansfont{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]}
\providecommand\songti{\CJKfamily{\CJKrmdefault}}
\providecommand\heiti{\CJKfamily{\CJKsfdefault}}
\usefonttheme{professionalfonts}
\IfFontExistsTF{Arial}{\setsansfont{Arial}}{\setsansfont{texgyreheros-regular.otf}[
  BoldFont=texgyreheros-bold.otf,ItalicFont=texgyreheros-italic.otf,
  BoldItalicFont=texgyreheros-bolditalic.otf]}
\IfFontExistsTF{Times New Roman}{\setmainfont{Times New Roman}}{\setmainfont{texgyretermes-regular.otf}[
  BoldFont=texgyretermes-bold.otf,ItalicFont=texgyretermes-italic.otf,
  BoldItalicFont=texgyretermes-bolditalic.otf]}
\RequirePackage{unicode-math}
\setmathfont{texgyretermes-math.otf}

% 深红取自 Word 封面原件的校徽。页边距按页面宽度统一计算。
\definecolor{sdjuaccent}{HTML}{5C0D12}
\definecolor{sdjutext}{HTML}{22262B}
\definecolor{sdjumuted}{HTML}{50565D}
\definecolor{sdjusurface}{HTML}{F4F1F0}
\newlength\sdju@margin
\setlength\sdju@margin{.06\paperwidth}
\setbeamersize{text margin left=\sdju@margin,text margin right=\sdju@margin}
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{headline}{}
\setbeamertemplate{section in toc}[sections numbered]
\setbeamertemplate{caption}[numbered]
\renewcommand\figurename{图}
\renewcommand\tablename{表}
\setbeamercolor{normal text}{fg=sdjutext,bg=white}
\setbeamercolor{structure}{fg=sdjuaccent}
\setbeamercolor{alerted text}{fg=sdjuaccent}
\setbeamercolor{frametitle}{fg=sdjuaccent}
\setbeamercolor{title}{fg=sdjuaccent}
\setbeamercolor{caption name}{fg=sdjuaccent}
\setbeamercolor{sdju note}{fg=sdjumuted,bg=sdjusurface}
\setbeamerfont{title}{size=\LARGE,series=\bfseries}
\setbeamerfont{frametitle}{size=\Large,series=\bfseries}
\setbeamerfont{caption}{size=\small}
\setbeamerfont{sdju note}{size=\small}
\setbeamerfont{section in toc}{size=\large}
\setbeamerfont{sdju divider}{size=\LARGE,series=\bfseries}
\setbeamerfont{page number in head/foot}{size=\scriptsize}

\setbeamertemplate{frametitle}{%
  \nointerlineskip
  \begin{beamercolorbox}[wd=\textwidth]{frametitle}
    \vskip .55em
    \usebeamerfont{frametitle}\raggedright\insertframetitle\par
    \vskip .35em
    {\color{sdjuaccent}\rule{2.4em}{.6pt}}\par
  \end{beamercolorbox}%
}

% 页脚保留一行。未指定短题目且题目过长时显示通用答辩名称。
\newsavebox\sdju@footbox
\setbeamertemplate{footline}{%
  \begin{beamercolorbox}[wd=\paperwidth,sep=.55em,
      leftskip=\sdju@margin,rightskip=\sdju@margin]{sdju note}%
    \usebeamerfont{page number in head/foot}%
    \sbox\sdju@footbox{\insertshorttitle}%
    \ifdim\wd\sdju@footbox>.75\textwidth
      \sdju@defensename%
    \else
      \usebox\sdju@footbox
    \fi
    \hfill\insertframenumber\,/\,\inserttotalframenumber
  \end{beamercolorbox}%
}

% 封面信息沿用论文接口。答辩日期写入 Beamer 的日期字段。
\newcommand\sdju@titleen{}
\newcommand\sdju@studentid{}
\newcommand\sdju@major{}
\newcommand\sdju@school{}
\newcommand\sdju@supervisor{}
\newcommand\sdju@companysupervisor{}
\newcommand\titleen[1]{\renewcommand\sdju@titleen{#1}}
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\newcommand\major[1]{\renewcommand\sdju@major{#1}}
\newcommand\school[1]{\renewcommand\sdju@school{#1}}
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}
\newcommand\companysupervisor[1]{\renewcommand\sdju@companysupervisor{#1}}
\newcommand\defensedate[1]{\date{#1}}
% 封面题目上方、页脚（题目过长时）的答辩名称：\defensename{…}；留空为「毕业设计（论文）答辩」
\newcommand\sdju@defensenamedefault{毕业设计（论文）答辩}
\newcommand\sdju@defensenamesrc{}
\newcommand\defensename[1]{\renewcommand\sdju@defensenamesrc{#1}}
\newcommand\sdju@defensename{\ifx\sdju@defensenamesrc\@empty\sdju@defensenamedefault\else\sdju@defensenamesrc\fi}
\defensedate{}

\setbeamertemplate{title page}{%
  \includegraphics[width=.29\textwidth]{figures/sdju-logo.jpg}\par
  \medskip
  {\color{sdjumuted}\small \sdju@defensename\par}
  \smallskip
  {\usebeamercolor[fg]{title}\usebeamerfont{title}\raggedright\inserttitle\par}
  \ifx\sdju@titleen\@empty\else
    \smallskip
    {\color{sdjumuted}\small\raggedright\sdju@titleen\par}
  \fi
  \medskip
  {\color{sdjuaccent}\rule{\textwidth}{.6pt}\par}
  \smallskip
  {\small
    \begin{columns}[T,onlytextwidth]
      \begin{column}{.48\textwidth}
        学生姓名\enspace\insertauthor\par
        学生学号\enspace\sdju@studentid\par
        专业\enspace\sdju@major\par
        学院\enspace\sdju@school
      \end{column}
      \begin{column}{.48\textwidth}
        校内指导教师\enspace\sdju@supervisor\par
        企业指导教师\enspace\sdju@companysupervisor\par
        答辩日期\enspace\insertdate
      \end{column}
    \end{columns}}
}

\newcommand\makecover{\frame[plain,noframenumbering]{\titlepage}}
\newcommand\sdjutableofcontents{%
  \frame{\frametitle{目录}\tableofcontents[hideallsubsections]}}

\newcommand\sdju@divider[2]{%
  {\usebeamercolor[fg]{structure}#1\par}
  \smallskip
  {\color{sdjuaccent}\rule{2.4em}{.6pt}\par}
  \medskip
  {\usebeamerfont{sdju divider}\raggedright #2\par}%
}
\AtBeginSection[]{%
  \frame{\sdju@divider{第 \insertsectionnumber\ 节}{\insertsectionhead}}}
% 致谢页：\sdjuthanks[大字标题]{致谢文字}；大字标题默认「谢谢各位老师」
\newcommand\sdjuthanks[2][谢谢各位老师]{%
  \frame[plain,noframenumbering]{\sdju@divider{致谢}{#1}\medskip #2}}

% 放在图表题注之后。路径用 \path{...}，以便在较长路径中断行。
\newcommand\sdjusource[1]{%
  \par\smallskip
  {\usebeamerfont{sdju note}\color{sdjumuted}来源：#1\par}}
\lstset{basicstyle=\ttfamily,columns=fullflexible,keepspaces=true,
  showstringspaces=false,breaklines=true,
  keywordstyle=\color{sdjuaccent}\bfseries,
  backgroundcolor=\color{sdjusurface}}
