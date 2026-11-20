%% sdjutaskbook.cls
%% 上海电机学院 毕业设计（论文）任务书 LaTeX 模板
%% 依据：《教学归档材料及质量评价要素（2026 版）》附件22《毕业设计（论文）任务书》
%%
%% 行距约定：「单倍行距」= 15.6bp，「1.25 倍」= 19.5bp。
%% 编译：xelatex（或直接 latexmk taskbook.tex）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjutaskbook}[2026/11/20 v1.0 SDJU Task Book Template]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\LoadClass[UTF8,a4paper,oneside,zihao=-4,linespread=1,fontset=none]{ctexart}

% ===============================================================
% 宏包
% ===============================================================
\RequirePackage{xparse}
\RequirePackage{calc}
\RequirePackage{etoolbox}
\RequirePackage{geometry}
\RequirePackage{amsmath,amssymb}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{tikz}

% ===============================================================
% 字体：宋体 / 黑体 / 楷体 / 仿宋 / Times New Roman，封面校名用华文中宋；
%   找不到时用 Fandol / TeX Gyre Termes
% ===============================================================
\providecommand\songti{}\providecommand\heiti{}
\providecommand\kaishu{}\providecommand\fangsong{}
\IfFontExistsTF{SimSun}{%
  \setCJKmainfont{SimSun}[AutoFakeBold=2,AutoFakeSlant=.2]
  \setCJKsansfont{SimHei}[AutoFakeBold=2]
  \setCJKmonofont{SimSun}
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold=2,AutoFakeSlant=.2]
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold=2]
  \IfFontExistsTF{KaiTi}{\setCJKfamilyfont{zhkai}{KaiTi}}{\setCJKfamilyfont{zhkai}{SimSun}}
  \IfFontExistsTF{FangSong}{\setCJKfamilyfont{zhfs}{FangSong}}{\setCJKfamilyfont{zhfs}{SimSun}}
}{%
  \setCJKmainfont{FandolSong-Regular.otf}[BoldFont=FandolSong-Bold.otf]
  \setCJKsansfont{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]
  \setCJKmonofont{FandolFang-Regular.otf}
  \setCJKfamilyfont{zhsong}{FandolSong-Regular.otf}[BoldFont=FandolSong-Bold.otf]
  \setCJKfamilyfont{zhhei}{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]
  \setCJKfamilyfont{zhkai}{FandolKai-Regular.otf}
  \setCJKfamilyfont{zhfs}{FandolFang-Regular.otf}
}
\renewcommand\songti{\CJKfamily{zhsong}}
\renewcommand\heiti{\CJKfamily{zhhei}}
\renewcommand\kaishu{\CJKfamily{zhkai}}
\renewcommand\fangsong{\CJKfamily{zhfs}}
\IfFontExistsTF{Times New Roman}{\setmainfont{Times New Roman}}
  {\setmainfont{texgyretermes}[Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
     ItalicFont=*-italic,BoldItalicFont=*-bolditalic]}
\IfFontExistsTF{Arial}{\setsansfont{Arial}}
  {\setsansfont{texgyreheros}[Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
     ItalicFont=*-italic,BoldItalicFont=*-bolditalic]}
\RequirePackage{unicode-math}
\setmathfont{texgyretermes-math.otf}
\xeCJKDeclareCharClass{CJK}{"25A1,"221A}   % □ √ 用中文字体
% 华文中宋（封面校名用，无则用宋体加粗）
\IfFontExistsTF{STZhongsong}
  {\setCJKfamilyfont{sdjuzhongsong}{STZhongsong}[AutoFakeBold=2]\newcommand\sdju@zhongsong{\CJKfamily{sdjuzhongsong}}}
  {\newcommand\sdju@zhongsong{\songti\bfseries}}

% ===============================================================
% 格式参数（字号单位 bp，即 Word 中的「磅」）
% ===============================================================
\newcommand\sdjufont[2]{\fontsize{#1}{#2}\selectfont}
\def\sdju@grid{15.6bp}                       % 单倍行距
% 表格内填写的内容：小四号宋体 / Times New Roman，1.25 倍行距，首行缩进 2 字符
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{19.5bp}%
  \abovedisplayskip 6bp plus 3bp minus 3bp
  \abovedisplayshortskip 0bp plus 3bp
  \belowdisplayshortskip 6bp plus 3bp minus 3bp
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
% 按 Word 的「x 倍行距」设置当前字号的行距：\sdjuspacing{1.5}
\ExplSyntaxOn
\NewDocumentCommand\sdjuspacing{m}
  {\fontsize{\f@size}{\fp_eval:n{#1*15.6}bp}\selectfont}
\ExplSyntaxOff

% 断行：与 Word 一致，英文单词不用连字符拆开；排不下时放宽词距
\hyphenpenalty=10000
\tolerance=1000
\setlength{\emergencystretch}{3em}

% 列表：(1)、(2)…，与正文同样首行缩进 2 字符
\setlist{nosep}
\setlist[enumerate,1]{label=(\arabic*),leftmargin=0pt,labelindent=2em,
  itemindent=*,labelsep=0.5em,align=left,listparindent=2em}
\setlist[itemize,1]{leftmargin=0pt,labelindent=2em,itemindent=*,
  labelsep=0.5em,listparindent=2em}
% 公式编号使用全角括号
\renewcommand\tagform@[1]{\maketag@@@{（\ignorespaces#1\unskip\@@italiccorr）}}

% ===============================================================
% 页面：A4；上、下 2.54cm，左、右 3.17cm（90 磅）；不印页眉页脚和页码（附件22 的表格本身没有页码）
% ===============================================================
\geometry{a4paper,top=72bp,bottom=72bp,left=90bp,right=90bp,
  headheight=0pt,headsep=0pt,footskip=0pt}
\pagestyle{empty}
\raggedbottom

% ===============================================================
% 信息
% ===============================================================
\newcommand\sdju@title{}
\newcommand\sdju@school{}
\newcommand\sdju@major{}
\newcommand\sdju@classname{}
\newcommand\sdju@studentid{}
\newcommand\sdju@author{}
\newcommand\sdju@supervisor{}
\newcommand\sdju@companysupervisor{}
\newcommand\sdju@taskdate{年\hspace{2em}月\hspace{2em}日}
\renewcommand\title[1]{\renewcommand\sdju@title{#1}}
\newcommand\school[1]{\renewcommand\sdju@school{#1}}
\newcommand\major[1]{\renewcommand\sdju@major{#1}}
\newcommand\classname[1]{\renewcommand\sdju@classname{#1}}
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\renewcommand\author[1]{\renewcommand\sdju@author{#1}}
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}
\newcommand\companysupervisor[1]{\renewcommand\sdju@companysupervisor{#1}}
\newcommand\taskdate[1]{\renewcommand\sdju@taskdate{#1}}

% ===============================================================
% 封面（附件22 第 1 页）
%   版心左上角起 432 × 624 磅的方框，线粗 1.5 磅；框内各行的基线位置：
%     校名「上海电机学院」：小初号华文中宋，基线距框顶 61 磅，居中
%     「毕业设计（论文）任务书」：一号宋体，基线再下 52 磅，居中
%     其下各栏目行按 40 磅等距排（Word 中为固定行距 40 磅），小三号宋体，栏目名缩进 82 磅：
%       （空两行）课题（两行下划线）／空一行／专业／班级／姓名、学号／空一行／
%       学院院长（签字）／校内指导教师（签字）／企业指导教师（签字）／（空 1.5 行）年 月 日
%   框外下方一行「注：本任务书由上海电机学院教务处印制。」五号楷体
%   课题名称一行写不下时自动转到第二条下划线，两行仍排不下则逐级缩小字号。
%   学院院长、校内指导教师、企业指导教师三栏须手签，模板不印姓名。
% ===============================================================
\newlength\sdju@coverpitch  \setlength\sdju@coverpitch{40bp}% 栏目行距
\newlength\sdju@coverindent \setlength\sdju@coverindent{82bp}% 栏目名缩进
\newlength\sdju@coverw      \setlength\sdju@coverw{240bp}% 栏目下划线长度
\newcommand\sdju@coverlabelw{2.5em}% 「课 题」等两字栏目名所占宽度（按小三号计）
% 一行（不占高度）：#1 与上一行基线的距离，#2 内容
\newcommand\sdju@coverat[2]{\kern#1\hbox to\hsize{\smash{\hbox to\hsize{#2}}}}
% 一条下划线及写在上面的内容（居中）：#1 宽度，#2 内容
\newcommand\sdju@uline[2]{%
  \rlap{\rule[-1.6bp]{#1}{0.72bp}}%
  \hbox to#1{\hss#2\hss}}
% 栏目行：#1 栏目名，#2 内容
\newcommand\sdju@coverfield[2]{%
  \hskip\sdju@coverindent\makebox[\sdju@coverlabelw][s]{#1}\hskip 0.5em
  \sdju@uline{\sdju@coverw}{#2}\hfil}
% 签字行：#1 栏目名；下划线右端与上面的栏目下划线对齐
\newcommand\sdju@coversign[1]{%
  \hskip\sdju@coverindent\setbox\z@\hbox{#1}\copy\z@
  \sdju@uline{\dimexpr\sdju@coverlabelw+0.5em+\sdju@coverw-\wd\z@\relax}{}\hfil}
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
    \ClassWarningNoLine{sdjutaskbook}{课题名称过长，封面上两行排不下，请缩短或用 \string\\ 手工分行}%
  \fi}
\newcommand\makecover{%
  \clearpage\thispagestyle{empty}%
  \begingroup
  \songti\sdju@fittitle
  \noindent
  \begin{tikzpicture}[remember picture,overlay]
    \draw[line width=1.5bp]
      ([xshift=90bp,yshift=-72bp]current page.north west) rectangle ++(432bp,-624bp);
  \end{tikzpicture}%
  \vbox to\z@{\offinterlineskip \sdjufont{15bp}{15bp}%
    \kern-\topskip
    \sdju@coverat{61bp}{\hfil\sdju@zhongsong\sdjufont{36bp}{36bp}上海电机学院\hfil}%
    \sdju@coverat{52bp}{\hfil\sdjufont{26bp}{26bp}毕业设计（论文）任务书\hfil}%
    \sdju@coverat{2\sdju@coverpitch}{%
      \ifvoid\sdju@tla \sdju@coverfield{课\hfill 题}{\copy\sdju@tlb}%
      \else \sdju@coverfield{课\hfill 题}{\copy\sdju@tla}\fi}%
    \sdju@coverat{\sdju@coverpitch}{%
      \ifvoid\sdju@tla \sdju@coverfield{}{}\else \sdju@coverfield{}{\box\sdju@tlb}\fi}%
    \sdju@coverat{2\sdju@coverpitch}{\sdju@coverfield{专\hfill 业}{\sdju@major}}%
    \sdju@coverat{\sdju@coverpitch}{\sdju@coverfield{班\hfill 级}{\sdju@classname}}%
    \sdju@coverat{\sdju@coverpitch}{%
      \hskip\sdju@coverindent\makebox[\sdju@coverlabelw][s]{姓\hfill 名}\hskip 0.5em
      \sdju@uline{\dimexpr(\sdju@coverw-\sdju@coverlabelw)/2\relax}{\sdju@author}%
      \makebox[\sdju@coverlabelw][s]{学\hfill 号}%
      \sdju@uline{\dimexpr(\sdju@coverw-\sdju@coverlabelw)/2\relax}{\sdju@studentid}\hfil}%
    \sdju@coverat{2\sdju@coverpitch}{\sdju@coversign{学院院长（签字）}}%
    \sdju@coverat{\sdju@coverpitch}{\sdju@coversign{校内指导教师（签字）}}%
    \sdju@coverat{\sdju@coverpitch}{\sdju@coversign{企业指导教师（签字）}}%
    \sdju@coverat{1.5\sdju@coverpitch}{\hfil\sdju@taskdate\hfil}%
    % 框外的注：在框底下一个栏目行距处
    \sdju@coverat{\dimexpr 624bp+\sdju@coverpitch-61bp-52bp-12.5\sdju@coverpitch\relax}%
      {\kaishu\sdjufont{10.5bp}{10.5bp}注：本任务书由上海电机学院教务处印制。\hfil}%
    \vss}%
  \par\endgroup
  \clearpage}

% ===============================================================
% 表格（附件22 第 2 页「任务书反面」）
%   表格宽 462 磅，左边线伸出版心左边 5.4 磅（Word 表格默认的单元格边距）；线粗 0.5 磅。
%   左格为竖排栏目名（宽 32.4 磅，四号仿宋，字距 22 磅），右格为填写内容。
%   每个栏目可跨页：内容写不下时在页底断开、下一页接着排（续页不重复栏目名）；
%   内容少时按「最小高度」留白（取自附件22 各行的高度）。
% ===============================================================
\newlength\sdju@formw      \setlength\sdju@formw{462bp}%   表格总宽
\newlength\sdju@formshift  \setlength\sdju@formshift{-5.4bp}% 表格左边线相对版心左边的位移
\newlength\sdju@rule       \setlength\sdju@rule{0.5bp}%     内框线
\newlength\sdju@orule      \setlength\sdju@orule{0.5bp}%    左右外框线
\newlength\sdju@labelw     \setlength\sdju@labelw{32.4bp}%  竖排栏目名格宽（含其右侧竖线）
\newlength\sdju@padx       \setlength\sdju@padx{5.4bp}%     单元格左右内边距
\newlength\sdju@pady       \setlength\sdju@pady{4bp}%       单元格上下内边距
\newlength\sdju@cw         % 内容格中文字的宽度
\newlength\sdju@avail \newlength\sdju@minh \newlength\sdju@tmpa
\newbox\sdju@body \newbox\sdju@tail \newbox\sdju@piece \newbox\sdju@label
\newif\ifsdju@firstpiece
\newcommand\sdju@labelfont{\fangsong\sdjufont{14bp}{22bp}}
% 竖排栏目名：每字一行，居中
\newcommand\sdju@makelabel[1]{%
  \setbox\sdju@label\vbox{\hsize=\dimexpr\sdju@labelw-\sdju@rule\relax
    \sdju@labelfont \baselineskip=22bp \lineskip=\z@ \lineskiplimit=\z@
    \@tfor\sdju@ch:=#1\do{\hbox to\hsize{\hss\sdju@ch\hss}}}}
\newcommand\sdju@setcw{%
  \setlength\sdju@cw{\sdju@formw-2\sdju@orule-2\sdju@padx}%
  \ifdim\sdju@labelw>\z@ \addtolength\sdju@cw{-\sdju@labelw}\fi}
% 内容格的排版环境
\newcommand\sdju@bodysetup{%
  \hsize=\sdju@cw \linewidth=\hsize \columnwidth=\hsize \@totalleftmargin=\z@
  \normalfont\normalsize\parindent=2em \parskip=\z@
  \everypar{}}
% 输出一段：#1 段内文字区高度；\sdju@piece 为内容
\newcommand\sdju@outpiece[1]{%
  \nointerlineskip
  \moveright\sdju@formshift\vbox{%
    \hrule height\sdju@rule width\sdju@formw
    \hbox to\sdju@formw{%
      \vrule width\sdju@orule
      \ifdim\sdju@labelw>\z@
        \vbox to\dimexpr#1+2\sdju@pady\relax{\hsize=\dimexpr\sdju@labelw-\sdju@rule\relax
          \vss\ifsdju@firstpiece\copy\sdju@label\fi\vss}%
        \vrule width\sdju@rule
      \fi
      \hskip\sdju@padx
      \vbox to\dimexpr#1+2\sdju@pady\relax{\hsize=\sdju@cw
        \vskip\sdju@pady\box\sdju@piece\vss}%
      \hfil\vrule width\sdju@orule}%
    \hrule height\sdju@rule width\sdju@formw}%
  \kern-\sdju@rule\prevdepth=\z@}
% 本页剩余可用高度（扣除边框与内边距）
\newcommand\sdju@getavail{%
  \par\penalty\@M
  \ifdim\pagegoal=\maxdimen \setlength\sdju@avail{\vsize}%
  \else \setlength\sdju@avail{\pagegoal-\pagetotal}\fi
  \addtolength\sdju@avail{-2\sdju@pady-2\sdju@rule}}
% 把 \sdju@body（内容）与 \sdju@tail（签名栏，可为空）排成一个栏目：#1 最小高度
\newcommand\sdju@formrow[1]{%
  \par
  \setlength\sdju@minh{#1}%
  \addtolength\sdju@minh{-2\sdju@pady-2\sdju@rule}%
  \ifvoid\sdju@label\else
    \ifdim\sdju@minh<\ht\sdju@label \setlength\sdju@minh{\ht\sdju@label}\fi
  \fi
  % 签名栏推到底部
  \setbox\sdju@body\vbox{\unvbox\sdju@body
    \ifvoid\sdju@tail\else \par\vskip 6bp plus 1fill \box\sdju@tail\fi}%
  \setlength\sdju@tmpa{\ht\sdju@body+\dp\sdju@body}% 内容的自然高度
  \sdju@getavail
  % 本页剩下不到 40 毫米、又放不下全部内容时，整个栏目移到下一页
  \ifdim\sdju@avail<40mm \ifdim\sdju@tmpa>\sdju@avail
    \newpage\sdju@getavail \fi\fi
  % 内容少于最小高度：留白到最小高度；但本页放得下内容、放不下最小高度时，只留白到本页底
  \ifdim\sdju@tmpa<\sdju@minh
    \ifdim\sdju@minh>\sdju@avail \setlength\sdju@minh{\sdju@avail}\fi
    \setbox\sdju@body\vbox to\sdju@minh{\unvbox\sdju@body\vfil}%
    \setlength\sdju@tmpa{\sdju@minh}%
  \fi
  \sdju@firstpiecetrue
  \splittopskip=14bp \splitmaxdepth=\maxdimen \vbadness=\@M
  \loop
    \ifdim\sdju@tmpa>\sdju@avail
      \setbox\sdju@piece\vsplit\sdju@body to\sdju@avail
      \sdju@outpiece{\sdju@avail}%
      \sdju@firstpiecefalse
      \newpage\sdju@getavail
      \setlength\sdju@tmpa{\ht\sdju@body+\dp\sdju@body}%
  \repeat
  \setbox\sdju@piece\box\sdju@body
  \sdju@outpiece{\sdju@tmpa}%
  \global\setbox\sdju@label\box\voidb@x
  \global\setbox\sdju@tail\box\voidb@x}

% ===============================================================
% 正文栏目（由指导教师填写）
%   \section{课题来源}、\section{课题的目的、意义}、\section{要求}、\section{课题主要内容及进度}
%   每个 \section 开始一个栏目，写到下一个 \section（或文档结束）为止；
%   可选参数为该栏目的最小高度：\section[60mm]{要求}。
%   第一个栏目之前印「任务书反面：」（小四号楷体），最后一个栏目之后印「以上各项由指导教师填写」（小四号仿宋）。
% ===============================================================
\newif\ifsdju@rowopen
\newif\ifsdju@formstarted
\newcommand\sdju@rowminh{30mm}
\newcommand\sdju@closerow{%
  \ifsdju@rowopen
    \par\egroup
    \global\sdju@rowopenfalse
    \sdju@formrow{\sdju@rowminh}%
  \fi}
\newcommand\sdju@closeform{%
  \sdju@closerow
  \ifsdju@formstarted
    \global\sdju@formstartedfalse
    \par\vskip 4bp\noindent{\fangsong\sdjufont{12bp}{15.6bp}以上各项由指导教师填写}\par
  \fi}
\AtEndDocument{\sdju@closeform}
% 各栏目的默认最小高度（附件22 中各行的高度）
\@namedef{sdju@minh@课题来源}{91.2bp}
\@namedef{sdju@minh@课题的目的、意义}{180.5bp}
\@namedef{sdju@minh@要求}{100.5bp}
\@namedef{sdju@minh@课题主要内容及进度}{274bp}
\RenewDocumentCommand\section{s o m}{%
  \sdju@closerow
  \ifsdju@formstarted\else
    \global\sdju@formstartedtrue
    \par\noindent{\kaishu\sdjufont{12bp}{15.6bp}任务书反面：}\par\vskip 6bp
  \fi
  \IfNoValueTF{#2}
    {\ifcsname sdju@minh@#3\endcsname
       \edef\sdju@rowminh{\csname sdju@minh@#3\endcsname}%
     \else \def\sdju@rowminh{30mm}\fi}
    {\def\sdju@rowminh{#2}}%
  \sdju@setcw
  \sdju@makelabel{#3}%
  \setcounter{subsection}{0}%
  \global\sdju@rowopentrue
  \setbox\sdju@body\vbox\bgroup\sdju@bodysetup}
% 栏目内的小标题：\subsection{…}，小四号宋体加粗，编号 1、2、3…；\subsection* 不编号
\RenewDocumentCommand\subsection{s m}{%
  \par\IfBooleanF{#1}{\stepcounter{subsection}}%
  \noindent{\bfseries\IfBooleanF{#1}{\arabic{subsection}\enspace}#2}\par\nobreak}

% 进度安排：\begin{schedule} \item{20XX年XX月--20XX年XX月}{工作内容} \end{schedule}
% 时间段之后的内容换行时与首行内容对齐
\newenvironment{schedule}
  {\par\setlength\parindent{2em}%
   \def\item##1##2{\par\settowidth\@tempdima{\hspace*{2em}##1：}%
     \hangindent\@tempdima\hangafter1 ##1：##2\par}}
  {\par}

\RequirePackage[hidelinks,unicode]{hyperref}
\graphicspath{{figures/}}
\endinput
