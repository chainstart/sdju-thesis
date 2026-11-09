%% sdjuproposal.cls
%% 上海电机学院 毕业设计（论文）开题报告 LaTeX 模板
%% 依据：附件13《毕业设计（论文）开题报告》；字体、字号、行距与论文模板共用 sdjubase.sty
%% 编译：xelatex -> biber -> xelatex -> xelatex（或直接 latexmk proposal.tex）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjuproposal}[2026/11/09 v1.1 SDJU Thesis Proposal Template]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\LoadClass[UTF8,a4paper,oneside,zihao=-4,linespread=1,fontset=none]{ctexart}

\RequirePackage{sdjubase}

% ===============================================================
% 页面：上 2.54cm，下 2cm，左、右 2.5cm；页脚距纸边 1.25cm；
%   页码在页脚右侧（小五号），封面无页码
%   footskip 为版心下沿到页码基线的距离：下边距 20mm 减页脚距纸边 12.5mm，
%   再减页码行框（小五号，11.7 磅）中基线以下的部分
% ===============================================================
\geometry{a4paper,top=25.4mm,bottom=20mm,left=25mm,right=25mm,
  headheight=0pt,headsep=0pt,
  footskip=\dimexpr 20mm-12.5mm-\sdju@below{9bp}{11.7bp}\relax}
\fancypagestyle{sdjuproposal}{%
  \fancyhf{}%
  \fancyfoot[R]{\sdjufont{9bp}{11.7bp}\thepage}%
  \renewcommand\headrulewidth{0pt}\renewcommand\footrulewidth{0pt}}
\pagestyle{sdjuproposal}
\raggedbottom

% ===============================================================
% 信息
% ===============================================================
\newcommand\sdju@title{}
\newcommand\sdju@subtitle{}
\newcommand\sdju@school{}
\newcommand\sdju@major{}
\newcommand\sdju@classname{}
\newcommand\sdju@studentid{}
\newcommand\sdju@author{}
\newcommand\sdju@supervisor{}
\newcommand\sdju@finaldate{20\hspace{1em}年\hspace{1em}月\hspace{1em}日}
\renewcommand\title[1]{\renewcommand\sdju@title{#1}}
\newcommand\subtitle[1]{\renewcommand\sdju@subtitle{#1}}
\newcommand\school[1]{\renewcommand\sdju@school{#1}}
\newcommand\major[1]{\renewcommand\sdju@major{#1}}
\newcommand\classname[1]{\renewcommand\sdju@classname{#1}}
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\renewcommand\author[1]{\renewcommand\sdju@author{#1}}
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}
\newcommand\finaldate[1]{\renewcommand\sdju@finaldate{#1}}

% ===============================================================
% 封面：边框内自上而下逐行排，每行占一个 Word 行框（1.5 倍行距，行框高 = 1.5 × 1.3 × 字号）
%   段前 18 磅；校名、「毕业设计（论文）开题报告」：一号华文中宋加粗，居中
%   空两行（三号）；各栏目：小二号宋体加粗，内容（小三号）写在下划线上；
%   课题名称占两行下划线，一行写不下时自动转到第二行（两行约 34 个汉字，再长则自动缩小字号）
%   空两行（三号）；定稿日期：小三号宋体加粗
% ===============================================================
\newlength\sdju@coverw \setlength\sdju@coverw{92mm}% 下划线长度
% 一行：#1 字号（bp 数值），#2 内容。行框高 1.95 × 字号，基线在行框顶下 1 个字号处
\newcommand\sdju@coverrow[2]{%
  \hbox to\hsize{\vrule width\z@ height #1bp depth 0.95\dimexpr#1bp\relax
    \sdjufont{#1bp}{#1bp}#2}}
% 一条下划线及写在上面的内容（居中，小三号）
\newcommand\sdju@coverline[1]{%
  \rlap{\rule[-3bp]{\sdju@coverw}{0.6bp}}%
  \hbox to\sdju@coverw{\hss\sdjufont{15bp}{15bp}#1\hss}}
% 栏目行：#1 栏目名（占 4 字宽），#2 内容；栏目名留空则只有下划线
\newcommand\sdju@coverfield[2]{%
  \sdju@coverrow{18}{\hskip 19mm\makebox[4em][s]{#1}\hskip 0.5em\sdju@coverline{#2}\hfil}}
% 课题名称按下划线宽度分成两行（\sdju@tla、\sdju@tlb）；小三号排不下时逐级缩小字号
\newbox\sdju@tla \newbox\sdju@tlb
\newcommand\sdju@striptail{% 去掉行与行之间的间距和惩罚，露出上一行
  \unskip\unpenalty\unskip\unpenalty\unskip\unpenalty\unskip\unpenalty\unskip}
\newcommand\sdju@splittitle[1]{%
  \setbox\z@\vbox{\hsize=\sdju@coverw \centering \parindent=\z@
    \sdjufont{#1}{#1}\baselineskip=1.5\dimexpr#1\relax \lineskiplimit=\z@ \lineskip=\z@
    \sdju@title\par
    \sdju@striptail \global\setbox\sdju@tlb\lastbox
    \sdju@striptail \global\setbox\sdju@tla\lastbox
    \sdju@striptail \setbox\tw@\lastbox
    \ifvoid\tw@ \global\@tempswafalse \else \global\@tempswatrue \fi}}
\newcommand\sdju@fittitle{%
  \@tfor\sdju@tmp:={15bp}{14bp}{13bp}{12bp}{10.5bp}{9bp}\do{%
    \sdju@splittitle{\sdju@tmp}%
    \if@tempswa\else\@break@tfor\fi}%
  \if@tempswa
    \ClassWarningNoLine{sdjuproposal}{课题名称过长，封面上两行排不下，请缩短或用 \string\\ 手工分行}%
  \fi}
\newcommand\makecover{%
  \clearpage\thispagestyle{empty}%
  \begingroup
  \songti\bfseries \sdju@fittitle
  \noindent
  \begin{tikzpicture}[remember picture,overlay]
    \draw[line width=0.5bp]
      ([xshift=25mm,yshift=-25.3mm]current page.north west) rectangle
      ([xshift=180.7mm,yshift=-245.7mm]current page.north west);
  \end{tikzpicture}%
  \vbox to\z@{\offinterlineskip
    \vskip\dimexpr 18bp-\topskip\relax
    \sdju@coverrow{26}{\hfil\sdju@zhongsong 上海电机学院\hfil}%
    \sdju@coverrow{26}{\hfil\sdju@zhongsong 毕业设计（论文）开题报告\hfil}%
    \vskip 62.4bp
    \ifvoid\sdju@tla
      \sdju@coverfield{课题名称}{\box\sdju@tlb}%
      \sdju@coverfield{}{}%
    \else
      \sdju@coverfield{课题名称}{\box\sdju@tla}%
      \sdju@coverfield{}{\box\sdju@tlb}%
    \fi
    \sdju@coverfield{学\hfill 院}{\sdju@school}%
    \sdju@coverfield{专\hfill 业}{\sdju@major}%
    \sdju@coverfield{班\hfill 级}{\sdju@classname}%
    \sdju@coverfield{学\hfill 号}{\sdju@studentid}%
    \sdju@coverfield{姓\hfill 名}{\sdju@author}%
    \sdju@coverfield{指导教师}{\sdju@supervisor}%
    \vskip 62.4bp
    \sdju@coverrow{15}{\hskip 37mm 定稿日期：\sdju@finaldate\hfil}%
    \vss}%
  \par\endgroup
  \clearpage
  \setcounter{page}{1}}

% ===============================================================
% 正文
%   课题名称：小一号宋体加粗居中；副标题右对齐
%   「摘要：」「关键词：」小四号加粗，内容小四号宋体；首行缩进 2 字符，1.25 倍行距
%   一级标题：四号宋体加粗，左对齐，行框 31.2 磅，段前段后 13 磅（「1 文献综述」）
%   二级标题：小四号宋体，首行缩进 2 字符（「3.1 …」）
%   正文：小四号宋体 / Times New Roman，首行缩进 2 字符，1.25 倍行距
% ===============================================================
\renewcommand\maketitle{%
  {\centering\songti\bfseries\sdjufont{24bp}{31.2bp}\sdju@title\par}%
  \ifx\sdju@subtitle\@empty\else
    {\raggedleft\songti\bfseries\sdjufont{24bp}{31.2bp}——\sdju@subtitle\par}%
  \fi
  \vspace{6bp}}
\newcommand\sdju@keywords{}
\newcommand\keywords[1]{\renewcommand\sdju@keywords{#1}}
\renewenvironment{abstract}
  {\par\textbf{摘要：}\ignorespaces}
  {\par\textbf{关键词：}\sdju@keywords\par}

\setcounter{secnumdepth}{2}
\ctexset{
  section={
    format=\sdju@headstart{14bp}{31.2bp}{13bp}{13bp}\raggedright\songti\bfseries\sdjufont{14bp}{31.2bp},
    name={,}, number=\arabic{section}, aftername=\enspace,
    beforeskip=\dimexpr 13bp+\sdju@pre{14bp}{31.2bp}\relax,
    afterskip=\dimexpr 13bp+\sdju@post{14bp}{31.2bp}\relax,
    indent=0pt, afterindent=true,
  },
  subsection={
    format=\sdju@headstart{12bp}{19.5bp}{0bp}{0bp}\raggedright\songti\sdjufont{12bp}{19.5bp},
    aftername=\enspace, indent=2em,
    beforeskip=0pt, afterskip=0pt, afterindent=true,
  },
}

% 进度安排：\begin{schedule} \item{20XX年XX月--20XX年XX月}{工作内容} \end{schedule}
% 时间段之后的内容换行时与首行内容对齐
\newenvironment{schedule}
  {\par\setlength\parindent{2em}%
   \def\item##1##2{\par\settowidth\@tempdima{\hspace*{2em}##1：}%
     \hangindent\@tempdima\hangafter1 ##1：##2\par}}
  {\par}

% 列表：(1)、(2)…，与正文同样首行缩进 2 字符
\setlist{nosep}
\setlist[enumerate,1]{label=(\arabic*),leftmargin=0pt,labelindent=2em,
  itemindent=*,labelsep=0.5em,align=left,listparindent=2em}
\setlist[itemize,1]{leftmargin=0pt,labelindent=2em,itemindent=*,
  labelsep=0.5em,listparindent=2em}

% 图、表、公式：按节编号；图表题与表格格式见 sdjubase.sty
\renewcommand\thefigure{\arabic{section}-\arabic{figure}}
\renewcommand\thetable{\arabic{section}-\arabic{table}}
\renewcommand\theequation{\arabic{section}-\arabic{equation}}
\counterwithin*{figure}{section}
\counterwithin*{table}{section}
\counterwithin*{equation}{section}

% ===============================================================
% 参考文献：另起一页；标题「参考文献：」小二号黑体加粗居中；
%   条目小四号，单倍行距，悬挂缩进 2 字符（著录格式与论文相同）
% ===============================================================
\defbibheading{sdjuproposal}[参考文献：]{%
  \clearpage
  {\centering\heiti\bfseries\sdjufont{18bp}{23.4bp}#1\par}\vspace{6bp}}
\AtBeginBibliography{\sdjufont{12bp}{\sdju@grid}}
\newcommand\sdjubibliography{\printbibliography[heading=sdjuproposal]}
% 不用 .bib 文献库时，手工录入：\begin{references} \item 作者. 题名[J]. …… \end{references}
% 条目自动编号 [1]、[2]…；正文中用 \sdjucite{1} 标注
\newenvironment{references}
  {\clearpage
   {\centering\heiti\bfseries\sdjufont{18bp}{23.4bp}参考文献：\par}\vspace{6bp}%
   \sdjufont{12bp}{\sdju@grid}\begin{sdju@reflist}}
  {\end{sdju@reflist}}

% ===============================================================
% 意见页（每张表占一页）：左侧为竖排栏目名，右侧为填写区
%   \supervisoropinion{<意见内容，可留空>}：指导教师意见
%   \committeeopinion：答辩小组意见与结论
% ===============================================================
\newlength\sdju@formw \newlength\sdju@labelw
\setlength\sdju@labelw{12mm}
\newcommand\sdju@vlabel[1]{\parbox{1em}{\centering\sdjufont{12bp}{24bp}#1}}
\tikzset{sdjuform/.style={line width=0.5bp}}
\newcommand\supervisoropinion[1]{%
  \clearpage
  \setlength\sdju@formw{\linewidth-0.5bp}%
  \noindent\begin{tikzpicture}[sdjuform]
    \def\H{220mm}
    \draw (0,0) rectangle (\sdju@formw,-\H);
    \draw (\sdju@labelw,0) -- (\sdju@labelw,-\H);
    \node at (0.5\sdju@labelw,-0.5*\H) {\sdju@vlabel{指导教师意见}};
    \node[anchor=north west,inner sep=4mm,text width=\sdju@formw-\sdju@labelw-8mm,align=justify]
      at (\sdju@labelw,0) {\sdjufont{12bp}{19.5bp}\setlength\parindent{2em}#1};
    \node[anchor=west] at ([xshift=55mm]\sdju@labelw,-\H+40mm) {\sdjufont{12bp}{15.6bp}指导教师签名：};
    \node[anchor=west] at ([xshift=100mm]\sdju@labelw,-\H+28mm)
      {\sdjufont{12bp}{15.6bp}年\hspace{2em}月\hspace{2em}日};
  \end{tikzpicture}\par}
\newcommand\sdju@box{□}
\newcommand\committeeopinion{%
  \clearpage
  \setlength\sdju@formw{\linewidth-0.5bp}%
  \noindent\begin{tikzpicture}[sdjuform]
    \def\Ha{95mm}\def\Hb{70mm}\def\Hc{55mm}
    \pgfmathsetlengthmacro\Hab{\Ha+\Hb}
    \pgfmathsetlengthmacro\H{\Ha+\Hb+\Hc}
    \draw (0,0) rectangle (\sdju@formw,-\H);
    \draw (\sdju@labelw,0) -- (\sdju@labelw,-\H);
    \draw (0,-\Ha) -- (\sdju@formw,-\Ha);
    \draw (\sdju@labelw,-\Hab) -- (\sdju@formw,-\Hab);
    \node at (0.5\sdju@labelw,-0.5*\Ha) {\sdju@vlabel{答辩小组意见}};
    \node at (0.5\sdju@labelw,-\Ha-0.5*\Hb-0.5*\Hc) {\sdju@vlabel{答辩小组结论}};
    % 答辩小组意见
    \node[anchor=north west,inner sep=4mm,text width=\sdju@formw-\sdju@labelw-8mm]
      at (\sdju@labelw,0) {\sdjufont{10.5bp}{23.4bp}\setlength\parindent{0pt}%
      1、论文选题：\sdju@box 有理论意义；\sdju@box 有工程背景；\sdju@box 有实用价值；\sdju@box 意义不大。\par
      2、论文的难度：\sdju@box 偏高；\sdju@box 适当；\sdju@box 偏低。\par
      3、论文的工作量：\sdju@box 偏大；\sdju@box 适当；\sdju@box 偏小。\par
      4、设计或研究方案的可行性：\sdju@box 好；\sdju@box 较好；\sdju@box 一般；\sdju@box 不可行。\par
      5、学生对文献资料及课题的了解程度：\sdju@box 好；\sdju@box 较好；\sdju@box 一般；\sdju@box 较差。\par
      6、学生在论文选题报告中反映出的综合能力和表达能力：\par
      \hspace*{2em}\sdju@box 好；\sdju@box 较好；\sdju@box 一般；\sdju@box 较差。\par
      7、学生在论文选题报告中反映出的创新能力：\par
      \hspace*{2em}\sdju@box 好；\sdju@box 较好；\sdju@box 一般；\sdju@box 较差。\par
      8、对论文选题报告的总体评价：\sdju@box 好；\sdju@box 较好；\sdju@box 一般；\sdju@box 较差\par
      （在相应的方块内作记号“√”）\par};
    % 建议
    \node[anchor=north west,inner sep=4mm] at (\sdju@labelw,-\Ha)
      {\sdjufont{12bp}{15.6bp}建议：};
    % 结论
    \node[anchor=north west,inner sep=4mm,text width=\sdju@formw-\sdju@labelw-8mm]
      at (\sdju@labelw,-\Hab) {\sdjufont{12bp}{27bp}\setlength\parindent{0pt}%
      答辩结论：\hspace{1em}通过\sdju@box\hspace{3em}不通过\sdju@box\par
      等第评定：\hspace{1em}优秀\sdju@box\hspace{1em}良好\sdju@box\hspace{1em}及格\sdju@box\par
      答辩小组组长签名：\par
      答辩小组组员签名：\par
      \hspace*{80mm}年\hspace{2em}月\hspace{2em}日\par};
  \end{tikzpicture}\par}

\RequirePackage[hidelinks,unicode]{hyperref}
\graphicspath{{figures/}}
\endinput
