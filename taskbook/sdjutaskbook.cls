%% sdjutaskbook.cls
%% 上海电机学院 毕业设计（论文）任务书 LaTeX 模板
%% 依据：《教学归档材料及质量评价要素（2026 版）》附件22《毕业设计（论文）任务书》
%%
%% 行距约定：Word 中文字体单倍行距 = 1.3 × 字号（小四号 15.6bp）；反面各栏正文四号 1.5 倍 = 27.3bp
%%   （一页放不下时自动减小，下限单倍，见 \sdju@choosespacing）。
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
% 加粗：样表中的「加粗」是 Word 的描边加粗（字形填充后再以字号 1/35 的线宽描边，2026 版 PDF
%   各附件实测均为字号的 2.86%）。宋体、黑体、楷体、仿宋、华文中宋没有粗体字形，用 XeTeX 的伪粗体
%   模拟：xdvipdfmx 的描边线宽为 AutoFakeBold × 字号（pt）/ 100，取 \sdju@fakebold = 2.85，与 Word 相同。
%   只用于真字体（Windows 字体）；Fandol 有粗体字形，找不到真字体时的设置与此无关。
\def\sdju@fakebold{2.85}
\newif\ifsdju@realfonts
\providecommand\songti{}\providecommand\heiti{}
\providecommand\kaishu{}\providecommand\fangsong{}
\IfFontExistsTF{SimSun}{%
  \sdju@realfontstrue
  \setCJKmainfont{SimSun}[AutoFakeBold=\sdju@fakebold,AutoFakeSlant=.2]
  \setCJKsansfont{SimHei}[AutoFakeBold=\sdju@fakebold]
  \setCJKmonofont{SimSun}
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold=\sdju@fakebold,AutoFakeSlant=.2]
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold=\sdju@fakebold]
  \IfFontExistsTF{KaiTi}{\setCJKfamilyfont{zhkai}{KaiTi}[AutoFakeBold=\sdju@fakebold]}{\setCJKfamilyfont{zhkai}{SimSun}[AutoFakeBold=\sdju@fakebold]}
  \IfFontExistsTF{FangSong}{\setCJKfamilyfont{zhfs}{FangSong}[AutoFakeBold=\sdju@fakebold]}
    {\setCJKfamilyfont{zhfs}{SimSun}[AutoFakeBold=\sdju@fakebold]}
}{%
  \setCJKmainfont{FandolSong-Regular.otf}[BoldFont=FandolSong-Bold.otf]
  \setCJKsansfont{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]
  \setCJKmonofont{FandolFang-Regular.otf}
  \setCJKfamilyfont{zhsong}{FandolSong-Regular.otf}[BoldFont=FandolSong-Bold.otf]
  \setCJKfamilyfont{zhhei}{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]
  \setCJKfamilyfont{zhkai}{FandolKai-Regular.otf}
  \setCJKfamilyfont{zhfs}{FandolFang-Regular.otf}[AutoFakeBold=2]
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
\xeCJKDeclareCharClass{CJK}{"25A1,"221A,"2460->"2469}   % □ √ ①～⑩ 用中文字体
% 华文中宋（封面校名用，无则用宋体加粗）
\IfFontExistsTF{STZhongsong}
  {\setCJKfamilyfont{sdjuzhongsong}{STZhongsong}[AutoFakeBold=\sdju@fakebold]\newcommand\sdju@zhongsong{\CJKfamily{sdjuzhongsong}}}
  {\newcommand\sdju@zhongsong{\songti\bfseries}}

% ===============================================================
% 格式参数（字号单位 bp，即 Word 中的「磅」）
% ===============================================================
\newcommand\sdjufont[2]{\fontsize{#1}{#2}\selectfont}
\def\sdju@grid{15.6bp}                       % 小四号单倍行距
% Word 中中文字体（宋体、仿宋等）不对齐网格时的单倍行距 = 1.3 × 字号；「x 倍行距」= x × 单倍行距。
% 文字在行框内上下居中：行框高 L、字号 s 时，基线在行框顶之下 (L - s)/2 + 0.86s（\sdju@ascent）。
\def\sdju@single{1.3}
% 表格内填写的内容（附件16 任务书反面各栏的段落格式，2026 版附件22 未另作规定）：
%   四号仿宋 / Times New Roman，1.5 倍行距（1.5 × 1.3 × 14 = 27.3 磅），两端对齐；
%   不设首行缩进（附件16 各栏段落没有缩进；样表没写明的按模板原样，不另加惯例）。
\def\sdju@bodysize{14bp}
\def\sdju@bodyskip{27.3bp}
% 反面四个栏目必须排在一页内（用户 2026-11-26 决定）：先按正常的 1.5 倍行距排；放不下时
%   逐级减小行距（每级 0.05 倍，下限单倍，字号不变），直到放进一页；单倍仍放不下时给出警告、
%   排到第二页（不截字）。所用倍数（以百分之一计）记在 .aux 中（\sdju@tbspacing），下一遍编译
%   按它排版，latexmk 会自动重新编译直到不再变化（见 \sdju@closeform）。
\newcommand\sdju@spacingmax{150}
\newcommand\sdju@spacingmin{100}
\newcommand\sdju@spacingstep{5}
\providecommand\sdju@tbspacing{\sdju@spacingmax}
\AtBeginDocument{%
  \ifnum\sdju@tbspacing=\sdju@spacingmax\else
    \edef\sdju@bodyskip{\fpeval{round(\sdju@tbspacing*\sdju@single*(\sdju@bodysize)/100,4)}pt}%
    \normalsize
  \fi}
\newcommand\sdju@bodyindent{0pt}
\newcommand\sdju@bodyfont{\fangsong}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{\sdju@bodysize}{\sdju@bodyskip}%
  \abovedisplayskip 6bp plus 3bp minus 3bp
  \abovedisplayshortskip 0bp plus 3bp
  \belowdisplayshortskip 6bp plus 3bp minus 3bp
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
\setlength{\parindent}{\sdju@bodyindent}
\setlength{\parskip}{0pt}
% 当前字号、行距下 Word 行框中基线距行框顶的距离
\newcommand\sdju@ascent{\dimexpr(\baselineskip-1em)/2+0.86em\relax}
% 格子中正文第一行：基线在格子上边线之下一个 \sdju@ascent（在竖直模式的开头使用）
\newcommand\sdju@firstline{\prevdepth=\dimexpr\baselineskip-\sdju@ascent\relax}
% 格子中正文最后一行：行框在基线之下还有 \sdju@desc（= 行距 - \sdju@ascent），补足到这个深度，
%   使末行与下边线之间留出 Word 行框的下半部分（附件16 单元格下边距为 0，空白由行距自然留出）
\newcommand\sdju@desc{\dimexpr\baselineskip-\sdju@ascent\relax}
\newcommand\sdju@lastline{\par\ifdim\prevdepth<\sdju@desc\vskip\dimexpr\sdju@desc-\prevdepth\relax\fi}
% 按 Word 的「x 倍行距」设置当前字号的行距：\sdjuspacing{1.5}（x × 1.3 × 字号）
\ExplSyntaxOn
\NewDocumentCommand\sdjuspacing{m}
  {\fontsize{\f@size}{\fp_eval:n{#1*\sdju@single*\f@size}pt}\selectfont}
\ExplSyntaxOff

% 断行：与 Word 一致，英文单词不用连字符拆开；排不下时放宽词距
\hyphenpenalty=10000
\tolerance=1000
\setlength{\emergencystretch}{3em}

% 编号列表（各模板统一）：全角括号「（1）」「（2）」…，编号后紧接内容（全角括号自带半字空白），
%   首行与正文同样缩进 \sdju@listindent（这里即不缩进），转行回到左边。依据与取舍见 README「编号列表」
\newcommand\sdju@listindent{\sdju@bodyindent}
\setlist{nosep}
\setlist[enumerate,1]{label=（\arabic*）,leftmargin=0pt,labelindent=\sdju@listindent,
  itemindent=*,labelsep=0pt,align=left,listparindent=\sdju@listindent}
% 第二级编号（用户 2026-11-26 决定）：「（1）」下一级用「①」「②」…，编号后紧接内容；
%   缩进、转行与第一级相同（首行缩进 \sdju@listindent，转行回到左边）。
%   ①～⑩ 用字体中的字符（U+2460～U+2469，宋体、Fandol 都有）；宋体、Fandol 没有 ⑪ 以后的字符，
%   第 11 项起画一个 1 字宽的圆圈，数字居中
\newcommand\sdju@circled[1]{\ifnum#1>10 \sdju@drawcircled{#1}\else\char\numexpr"245F+#1\relax\fi}
\newcommand\sdju@drawcircled[1]{\makebox[1em]{\raisebox{-0.12em}{\setlength\unitlength{1em}%
  \begin{picture}(1,1)\put(0.5,0.5){\circle{0.9}}\put(0.5,0.47){\makebox(0,0){%
    \fontsize{0.55em}{0.55em}\selectfont\number#1}}\end{picture}}}}
\newcommand\sdju@circlednum[1]{\expandafter\sdju@circled\csname c@#1\endcsname}
\AddEnumerateCounter{\sdju@circlednum}{\sdju@circled}{⑩}
\setlist[enumerate,2]{label=\sdju@circlednum*,leftmargin=0pt,labelindent=\sdju@listindent,
  itemindent=*,labelsep=0pt,align=left,listparindent=\sdju@listindent}
\setlist[itemize,1]{leftmargin=0pt,labelindent=\sdju@listindent,itemindent=*,
  labelsep=0.5em,listparindent=\sdju@listindent}
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
% 封面日期：源码中用 \taskdate 写了日期时照写；没有写时，若签名配置文件给了院长、校内或企业
%   指导教师的签字日期，取其中最晚的，写作「年 月 日」形式；都没有时为空白的「年 月 日」
\newcommand\sdju@taskdate{\sdju@getdate{dean,supervisor,company_supervisor}%
  \ifsdju@hasdate
    \sdju@dy\hspace{1em}年\hspace{1em}\sdju@dm\hspace{1em}月\hspace{1em}\sdju@dd\hspace{1em}日%
  \else 年\hspace{2em}月\hspace{2em}日\fi}
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
%     框内文字一律加粗（附件22 为宋体加粗；填写的内容随之加粗）
%     校名「上海电机学院」：小初号华文中宋，基线距框顶 61 磅，居中
%     「毕业设计（论文）任务书」：一号宋体，基线再下 52 磅，居中
%     「课题」一行：基线再下 77.5 磅（\sdju@coverhead）
%     其下各栏目行按 40 磅等距排（Word 中为固定行距 40 磅），小三号宋体，栏目名缩进 82 磅：
%       课题（两行下划线，长 241 磅）／空一行／专业／班级／姓名、学号（下划线总长 233.5 磅）／空一行／
%       学院院长（签字）／校内指导教师（签字）／企业指导教师（签字）（栏目名连下划线共 271 磅）／
%       （空 1.5 行）年 月 日；下划线线粗 0.72 磅，中线在基线下 1.6 磅
%   框外下方一行「注：本任务书由上海电机学院教务处印制。」五号楷体（不加粗），基线在框底下 43.5 磅
%   课题名称一行写不下时自动转到第二条下划线（两行长度均衡，见 \sdju@balance），两行仍排不下则逐级缩小字号。
%   学院院长、校内指导教师、企业指导教师三栏不印姓名：没有签名配置时留空，待手签；有配置时由系统
%   放入签名图片（见文末「电子签名」），三人的签名中心在同一条竖线上（最短的一条下划线，即企业
%   指导教师一栏的中心），高 30 磅，底部压在下划线上。
% ===============================================================
\newlength\sdju@coverpitch  \setlength\sdju@coverpitch{40bp}% 栏目行距
\newlength\sdju@coverhead   \setlength\sdju@coverhead{77.5bp}% 「任务书」一行基线到「课题」一行基线
\newlength\sdju@coverindent \setlength\sdju@coverindent{82bp}% 栏目名缩进
\newlength\sdju@coverw      \setlength\sdju@coverw{241bp}% 课题下划线长度
\newlength\sdju@coverfieldw \setlength\sdju@coverfieldw{233.5bp}% 专业、班级、姓名＋学号下划线的总长
\newlength\sdju@coversignw  \setlength\sdju@coversignw{271bp}% 签字行（栏目名＋下划线）的总长
\newlength\sdju@covernote   \setlength\sdju@covernote{43.5bp}% 框外「注」的基线在框底之下的距离
\newlength\sdju@ulinepos    \setlength\sdju@ulinepos{1.6bp}% 下划线中线在基线之下的距离
\newlength\sdju@ulinew      \setlength\sdju@ulinew{0.72bp}% 下划线线粗
\newcommand\sdju@coverlabelw{2.5em}% 「课 题」等两字栏目名所占宽度（按小三号计）
% 框内文字（校名、「毕业设计（论文）任务书」、栏目名、填写内容、日期）全部加粗（附件22 为宋体加粗）
\newcommand\sdju@coverfont{\songti\bfseries}
% 一行（不占高度）：#1 与上一行基线的距离，#2 内容
\newcommand\sdju@coverat[2]{\kern#1\hbox to\hsize{\smash{\hbox to\hsize{#2}}}}
% 一条下划线及写在上面的内容（居中）：#1 宽度，#2 内容
\newcommand\sdju@uline[2]{%
  \rlap{\rule[\dimexpr-\sdju@ulinepos-\sdju@ulinew/2\relax]{#1}{\sdju@ulinew}}%
  \hbox to#1{\hss#2\hss}}
% 栏目行：#1 栏目名，#2 内容，#3 下划线长度
\newcommand\sdju@coverfield[3][\sdju@coverfieldw]{%
  \hskip\sdju@coverindent\makebox[\sdju@coverlabelw][s]{#2}\hskip 0.5em
  \sdju@uline{#1}{#3}\hfil}
% 签字行：#1 签名角色，#2 栏目名；栏目名与下划线共长 \sdju@coversignw
\newcommand\sdju@coversignh{30bp}% 签名图片的高度
\newcommand\sdju@coversign[2]{%
  \hskip\sdju@coverindent\setbox\z@\hbox{#2}\copy\z@
  \setbox\tw@\hbox{企业指导教师（签字）}% 签名放在最短一条下划线的范围内（右端对齐）
  \rlap{\kern\dimexpr\wd\tw@-\wd\z@\relax\raise-\sdju@ulinepos\hbox{%
    \sdju@sign{#1}{\dimexpr\sdju@coversignw-\wd\tw@\relax}{\sdju@coversignh}}}%
  \sdju@uline{\dimexpr\sdju@coversignw-\wd\z@\relax}{}\hfil}
% 课题名称按下划线宽度分成两行（\sdju@tla、\sdju@tlb）；小三号排不下时逐级缩小字号
\newbox\sdju@tla \newbox\sdju@tlb
\newcommand\sdju@striptail{% 去掉行与行之间的间距和惩罚，露出上一行
  \unskip\unpenalty\unskip\unpenalty\unskip\unpenalty\unskip\unpenalty\unskip}
% 均衡折行（用户 2026-11-26 决定：长题目转行时两行长度大致相当，不让一两个字单独成行）：
%   \sdju@balance{内容} 在当前字体、\hsize 下求出与整宽排时行数相同的最小行宽 w（二分，精度 0.1 磅），
%   把 \leftskip、\rightskip 设为 (\hsize - w)/2 加上原有的伸展，各行仍居中、长度大致相当。
%   只有一行时不改动；用 \\ 手工分行时各段照原样（行宽不小于最长的一段）。
\newdimen\sdju@ballo \newdimen\sdju@balhi \newdimen\sdju@balw \newcount\sdju@baln
\newcommand\sdju@ballines[2]{% 行宽 #1 时 #2 排成几行（结果在 \count@）
  \setbox\z@\vbox{\hsize=#1\relax \hfuzz=\maxdimen \hbadness=\@M
    \leftskip=\z@\@plus1fil \rightskip=\leftskip \parfillskip=\z@skip \parindent=\z@
    \let\\\@normalcr % 手工分行在同一段内计行数
    #2\par\global\count@=\prevgraf}}
\newcommand\sdju@balance[1]{%
  \sdju@ballines{\hsize}{#1}\sdju@baln=\count@
  \ifnum\sdju@baln>\@ne
    \sdju@ballo=\z@ \sdju@balhi=\hsize
    \loop
      \sdju@balw=\dimexpr(\sdju@ballo+\sdju@balhi)/2\relax
      \sdju@ballines{\sdju@balw}{#1}%
      \ifnum\count@>\sdju@baln \sdju@ballo=\sdju@balw \else \sdju@balhi=\sdju@balw \fi
    \ifdim\dimexpr\sdju@balhi-\sdju@ballo\relax>0.1bp \repeat
    \leftskip=\dimexpr(\hsize-\sdju@balhi)/2\relax\@plus1fil
    \rightskip=\leftskip
  \fi}
\newcommand\sdju@splittitle[1]{%
  \setbox\z@\vbox{\hsize=\sdju@coverw \centering \parindent=\z@
    \sdjufont{#1}{#1}\baselineskip=1.5\dimexpr#1\relax \lineskiplimit=\z@ \lineskip=\z@
    \sdju@balance{\sdju@title}%
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
  \sdju@coverfont\sdju@fittitle
  \noindent
  \begin{tikzpicture}[remember picture,overlay]
    \draw[line width=1.5bp]
      ([xshift=90bp,yshift=-72bp]current page.north west) rectangle ++(432bp,-624bp);
  \end{tikzpicture}%
  \vbox to\z@{\offinterlineskip \sdjufont{15bp}{15bp}%
    \kern-\topskip
    \sdju@coverat{61bp}{\hfil\sdju@zhongsong\sdjufont{36bp}{36bp}上海电机学院\hfil}%
    \sdju@coverat{52bp}{\hfil\sdjufont{26bp}{26bp}毕业设计（论文）任务书\hfil}%
    \sdju@coverat{\sdju@coverhead}{%
      \ifvoid\sdju@tla \sdju@coverfield[\sdju@coverw]{课\hfill 题}{\copy\sdju@tlb}%
      \else \sdju@coverfield[\sdju@coverw]{课\hfill 题}{\copy\sdju@tla}\fi}%
    \sdju@coverat{\sdju@coverpitch}{%
      \ifvoid\sdju@tla \sdju@coverfield[\sdju@coverw]{}{}%
      \else \sdju@coverfield[\sdju@coverw]{}{\box\sdju@tlb}\fi}%
    \sdju@coverat{2\sdju@coverpitch}{\sdju@coverfield{专\hfill 业}{\sdju@major}}%
    \sdju@coverat{\sdju@coverpitch}{\sdju@coverfield{班\hfill 级}{\sdju@classname}}%
    \sdju@coverat{\sdju@coverpitch}{%
      \hskip\sdju@coverindent\makebox[\sdju@coverlabelw][s]{姓\hfill 名}\hskip 0.5em
      \sdju@uline{\dimexpr(\sdju@coverfieldw-\sdju@coverlabelw)/2\relax}{\sdju@author}%
      \makebox[\sdju@coverlabelw][s]{学\hfill 号}%
      \sdju@uline{\dimexpr(\sdju@coverfieldw-\sdju@coverlabelw)/2\relax}{\sdju@studentid}\hfil}%
    \sdju@coverat{2\sdju@coverpitch}{\sdju@coversign{dean}{学院院长（签字）}}%
    \sdju@coverat{\sdju@coverpitch}{\sdju@coversign{supervisor}{校内指导教师（签字）}}%
    \sdju@coverat{\sdju@coverpitch}{\sdju@coversign{company_supervisor}{企业指导教师（签字）}}%
    \sdju@coverat{1.5\sdju@coverpitch}{\hfil\sdju@taskdate\hfil}%
    % 框外的注：基线在框底之下 \sdju@covernote（不加粗）
    \sdju@coverat{\dimexpr 624bp+\sdju@covernote-61bp-52bp-\sdju@coverhead-10.5\sdju@coverpitch\relax}%
      {\mdseries\kaishu\sdjufont{10.5bp}{10.5bp}注：本任务书由上海电机学院教务处印制。\hfil}%
    \vss}%
  \par\endgroup
  \clearpage}

% ===============================================================
% 表格（附件22 第 2 页「任务书反面」）
%   表格宽 462 磅，左边线伸出版心左边 5.4 磅（Word 表格默认的单元格边距）；线粗 0.5 磅。
%   左格为竖排栏目名（宽 32.4 磅，四号仿宋，字距随行高而定，见下），右格为填写内容。
%   「任务书反面：」基线距版心顶 16 磅，表格上边线再下 7.6 磅；表后「以上各项由指导教师填写」
%   的基线在表格下边线之下 16.3 磅。各栏目的高度（最小高度）指相邻两条横线之间的距离。
%   每个栏目可跨页：内容写不下时在页底断开、下一页接着排（续页不重复栏目名）；
%   内容少时按「最小高度」留白（取自附件22 各行的高度）。
% ===============================================================
\newlength\sdju@formw      \setlength\sdju@formw{462bp}%   表格总宽
\newlength\sdju@formshift  \setlength\sdju@formshift{-5.4bp}% 表格左边线相对版心左边的位移
\newlength\sdju@rule       \setlength\sdju@rule{0.5bp}%     内框线
\newlength\sdju@orule      \setlength\sdju@orule{0.5bp}%    左右外框线
\newlength\sdju@labelw     \setlength\sdju@labelw{32.4bp}%  竖排栏目名格宽（含其右侧竖线）
\newlength\sdju@padx       \setlength\sdju@padx{5.4bp}%     单元格左右内边距
\newlength\sdju@pady       \setlength\sdju@pady{0bp}%       单元格上下内边距（附件16 为 0）
\newlength\sdju@cw         % 内容格中文字的宽度
\newlength\sdju@avail \newlength\sdju@minh \newlength\sdju@tmpa \newlength\sdju@tmpb
\newdimen\sdju@reserve % 栏目最后一段之下须与它留在同一页的高度（「以上各项由指导教师填写」一行）
\newbox\sdju@body \newbox\sdju@tail \newbox\sdju@piece \newbox\sdju@label
\newif\ifsdju@firstpiece
\newcommand\sdju@labelfont{\fangsong\sdjufont{14bp}{22bp}}
% 竖排栏目名：每字一行，居中。
%   标点（如「课题的目的、意义」中的「、」）按附件22 的排法单独占一行，但横排字体中标点的字形
%   在字身左下角，整字居中时看上去偏左、像是漏排；这里把标点的字身右移 \sdju@punctshift
%   （附件22 中为 3.8 磅，即 0.27 字），使字形落在栏目中线上，与上下文字对齐。
\newcommand\sdju@punctshift{0.27em}
%   字距（行距）按栏目的高度统一确定：栏目名从首字到末字的跨度为栏目高度的 \sdju@labelspan，
%   字距限制在 \sdju@labelpitchmin～\sdju@labelpitch 之间（附件22 各栏的字距为 22、18、25、25 磅，
%   正是 0.72 倍栏高的跨度、上限 25 磅的结果）；栏目名居中。可选参数为字距。
\newcommand\sdju@labelpitch{25bp}
\newcommand\sdju@labelpitchmin{18bp}
\newcommand\sdju@labelspan{0.72}
%   每个字占一个高为字距的行框，基线在行框底之上 \sdju@labeldesc；整列行框在栏目中上下居中
%   （与 Word 单元格垂直居中的排法相同）
\newcommand\sdju@labeldesc{0.32em}
\newlength\sdju@backtop  \setlength\sdju@backtop{16bp}%  「任务书反面：」基线距版心顶
\newlength\sdju@backgap  \setlength\sdju@backgap{7.6bp}% 「任务书反面：」基线到表格上边线（中线）
\newlength\sdju@notegap  \setlength\sdju@notegap{16.3bp}% 表格下边线到「以上各项由指导教师填写」基线
\newcount\sdju@nch
% 按栏目高度 #1（相邻两条横线之间）重排第 \sdju@i 个栏目的竖排栏目名
\newcommand\sdju@fitlabel[1]{%
  \expandafter\let\expandafter\sdju@labeltext\csname sdju@rowtext\the\sdju@i\endcsname
  \sdju@nch=\z@
  \expandafter\@tfor\expandafter\sdju@ch\expandafter:\expandafter=\sdju@labeltext\do{\advance\sdju@nch\@ne}%
  \ifnum\sdju@nch>\@ne
    \edef\sdju@pitch{\the\dimexpr\sdju@labelspan\dimexpr#1\relax/(\sdju@nch-1)\relax}%
    \ifdim\sdju@pitch>\sdju@labelpitch \edef\sdju@pitch{\sdju@labelpitch}\fi
    \ifdim\sdju@pitch<\sdju@labelpitchmin \edef\sdju@pitch{\sdju@labelpitchmin}\fi
    \sdju@relabel{\sdju@pitch}%
  \fi}
\newcommand\sdju@makelabel[2][\sdju@labelpitch]{%
  \setbox\sdju@label\vbox{\hsize=\dimexpr\sdju@labelw-\sdju@rule\relax
    \sdju@labelfont \baselineskip=#1\relax \lineskip=\z@ \lineskiplimit=\z@
    \def\sdju@strut{\vrule height\dimexpr#1-\sdju@labeldesc\relax depth\sdju@labeldesc width\z@}%
    \@tfor\sdju@ch:=#2\do{%
      \expandafter\in@\expandafter{\sdju@ch}{、，。；：！？}%
      \ifin@ \hbox to\hsize{\sdju@strut\hss\hbox to 1em{\kern\sdju@punctshift\rlap{\sdju@ch}\hss}\hss}%
      \else \hbox to\hsize{\sdju@strut\hss\sdju@ch\hss}\fi}}}
\newcommand\sdju@setcw{%
  \setlength\sdju@cw{\sdju@formw-2\sdju@orule-2\sdju@padx}%
  \ifdim\sdju@labelw>\z@ \addtolength\sdju@cw{-\sdju@labelw}\fi}
% 内容格的排版环境
\newcommand\sdju@bodysetup{%
  \hsize=\sdju@cw \linewidth=\hsize \columnwidth=\hsize \@totalleftmargin=\z@
  \normalfont\normalsize\sdju@bodyfont\parindent=\sdju@bodyindent \parskip=\z@
  \everypar{}\sdju@firstline}
% 输出一段：#1 段内文字区高度；\sdju@piece 为内容
\newcommand\sdju@outpiece[1]{%
  \nointerlineskip
  \moveright\sdju@formshift\vbox{%
    \hrule height\sdju@rule width\sdju@formw
    \hbox to\sdju@formw{%
      \vrule width\sdju@orule
      \ifdim\sdju@labelw>\z@
        \ifsdju@firstpiece \ifvoid\sdju@label\else
          \sdju@fitlabel{#1+2\sdju@pady+\sdju@rule}\fi\fi
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
% 本页剩余可用高度（扣除边框与内边距）；本页最后一行的深度（如「任务书反面：」一行到表格上边线的
%   距离）记在 \pagedepth 中、不在 \pagetotal 里，一并扣除
\newcommand\sdju@getavail{%
  \par\penalty\@M
  \ifdim\pagegoal=\maxdimen \setlength\sdju@avail{\vsize}%
  \else \setlength\sdju@avail{\pagegoal-\pagetotal-\pagedepth}\fi
  \addtolength\sdju@avail{-2\sdju@pady-2\sdju@rule}}
% 把 \sdju@body（内容）与 \sdju@tail（签名栏，可为空）排成一个栏目：#1 最小高度
\newcommand\sdju@formrow[1]{%
  \par
  \setlength\sdju@minh{#1}%
  \addtolength\sdju@minh{-2\sdju@pady-\sdju@rule}%
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
  % （扣除须留在同一页的 \sdju@reserve）
  \ifdim\sdju@tmpa<\sdju@minh
    \setlength\sdju@tmpb{\sdju@avail-\sdju@reserve}%
    \ifdim\sdju@minh>\sdju@tmpb
      \ifdim\sdju@tmpa>\sdju@tmpb \setlength\sdju@minh{\sdju@tmpa}%
      \else \setlength\sdju@minh{\sdju@tmpb}\fi
    \fi
    \setbox\sdju@body\vbox to\sdju@minh{\unvbox\sdju@body\vfil}%
    \setlength\sdju@tmpa{\sdju@minh}%
  \fi
  \sdju@firstpiecetrue
  \splittopskip=\sdju@ascent \splitmaxdepth=\maxdimen \vbadness=\@M
  \loop
    \ifdim\sdju@tmpa>\dimexpr\sdju@avail-\sdju@reserve\relax
      % 放不下就在本页底断开；全部放得下、只是放不下其后的一行时，少排一点，把那一行带到下一页
      \ifdim\sdju@tmpa>\sdju@avail \setlength\sdju@tmpb{\sdju@avail}%
      \else \setlength\sdju@tmpb{\sdju@avail-\sdju@reserve}\fi
      % 断开处的末行同样留出行框的下半部分
      \setbox\sdju@piece\vsplit\sdju@body to\dimexpr\sdju@tmpb-\sdju@desc\relax
      \sdju@outpiece{\sdju@tmpb}%
      \sdju@firstpiecefalse
      \newpage\sdju@getavail
      \setlength\sdju@tmpa{\ht\sdju@body+\dp\sdju@body}%
  \repeat
  \setbox\sdju@piece\box\sdju@body
  \sdju@outpiece{\sdju@tmpa}%
  \global\setbox\sdju@label\box\voidb@x
  \global\setbox\sdju@tail\box\voidb@x
  \sdju@reserve=\z@}

% ===============================================================
% 正文栏目（由指导教师填写）
%   \section{课题来源}、\section{课题的目的、意义}、\section{要求}、\section{课题主要内容及进度}
%   每个 \section 开始一个栏目，写到下一个 \section（或文档结束）为止；
%   可选参数为该栏目的最小高度：\section[60mm]{要求}。
%   第一个栏目之前印「任务书反面：」（小四号楷体），最后一个栏目之后印「以上各项由指导教师填写」（小四号仿宋）。
%   各栏目先排好存起来，到文档结束时一起输出，以便按整张表统一安排高度：
%     (1)「以上各项由指导教师填写」与表格末尾在同一页，不单独换页；
%     (2) 各栏目的内容本来一页放得下、只因最小高度（留白）放不下时，各栏目的留白按同一比例收缩，
%         使整张表与末行排在一页；
%     (3) 内容本身超过一页时，逐级减小正文行距（\sdju@choosespacing），直到排进一页；
%         单倍行距仍超过一页时给出警告，按最小高度排，在页底断开、下一页接着排。
% ===============================================================
\newif\ifsdju@rowopen
\newif\ifsdju@formstarted
\newcommand\sdju@rowminh{30mm}
\newcount\sdju@nrows \newcount\sdju@i
\newbox\sdju@note
\newlength\sdju@sumneed \newlength\sdju@sumfloor \newlength\sdju@fit
% 第 \sdju@i 个栏目的内容高度 \sdju@tmpa、留白下限 \sdju@tmpb（竖排栏目名的高度）与最小高度 \sdju@minh
%   （均为格内文字区的高度，不含内边距和框线）
%   竖排栏目名按最小字距排时的高度记在 \sdju@labmin；下限 \sdju@tmpb 取内容高度与 \sdju@labmin 的较大者
\newdimen\sdju@labmin
\newcommand\sdju@rowdims{%
  \setlength\sdju@tmpa{\ht\csname sdju@rowbox\the\sdju@i\endcsname
    +\dp\csname sdju@rowbox\the\sdju@i\endcsname}%
  \begingroup
    \sdju@relabel{\sdju@labelpitchmin}%
    \global\sdju@labmin=\dimexpr\ht\sdju@label+\dp\sdju@label\relax
  \endgroup
  \setlength\sdju@tmpb{\sdju@labmin}%
  \ifdim\sdju@tmpb<\sdju@tmpa \setlength\sdju@tmpb{\sdju@tmpa}\fi
  \setlength\sdju@minh{\csname sdju@rowminh\the\sdju@i\endcsname}%
  \addtolength\sdju@minh{-2\sdju@pady-\sdju@rule}%
  \ifdim\sdju@minh<\sdju@tmpb \setlength\sdju@minh{\sdju@tmpb}\fi}
% 按字距 #1 重排第 \sdju@i 个栏目的竖排栏目名（放在 \sdju@label 中）
\newcommand\sdju@relabel[1]{%
  \expandafter\let\expandafter\sdju@labeltext\csname sdju@rowtext\the\sdju@i\endcsname
  \expandafter\sdju@relabel@i\expandafter{\sdju@labeltext}{#1}}
\newcommand\sdju@relabel@i[2]{\sdju@makelabel[#2]{#1}}
\newcommand\sdju@closerow{%
  \ifsdju@rowopen
    \sdju@lastline\egroup
    \global\sdju@rowopenfalse
    \global\advance\sdju@nrows\@ne
    \ifcsname sdju@rowbox\the\sdju@nrows\endcsname\else
      \expandafter\newbox\csname sdju@rowbox\the\sdju@nrows\endcsname
      \expandafter\newbox\csname sdju@rowlab\the\sdju@nrows\endcsname
    \fi
    \global\setbox\csname sdju@rowbox\the\sdju@nrows\endcsname\box\sdju@body
    \global\setbox\csname sdju@rowlab\the\sdju@nrows\endcsname\box\sdju@label
    \expandafter\xdef\csname sdju@rowminh\the\sdju@nrows\endcsname{\sdju@rowminh}%
    \global\expandafter\let\csname sdju@rowtext\the\sdju@nrows\endcsname\sdju@curlabel
  \fi}
% 选定反面正文的行距（\sdju@closeform 中调用；\sdju@cont<i>、\sdju@labm<i> 为本遍第 i 个栏目的
%   内容高度和竖排栏目名的下限，\sdju@fit 为本页可用高度）：
%   本遍按 f 倍（\sdju@tbspacing）排出的内容高度为 c_i，按 g 倍排时估为 c_i × g / f（文字各行的
%   行框都与行距成正比；图表等不随行距变化）。从 1.5 倍起每级减 0.05 倍，取第一个使
%   Σ max(c_i × g / f, 栏目名下限) 小于可用高度的 g，下限单倍。图表使估算在减小行距时偏乐观、
%   在增大行距时偏保守，所以试排只会逐级向下，不会在两档之间来回跳；g 与本遍不同时写入 .aux，
%   提示重新编译。单倍仍放不下时给出警告，内容在页底断开、排到第二页。
\newcount\sdju@spg \newcount\sdju@spnew
\newif\ifsdju@spmore
\newcommand\sdju@choosespacing{%
  \sdju@spnew=\z@
  \sdju@spg=\sdju@spacingmax\relax
  \loop
    \setlength\sdju@tmpb{\z@}%
    \sdju@i=\z@
    \@whilenum\sdju@i<\sdju@nrows\do{\advance\sdju@i\@ne
      \setlength\sdju@tmpa{\dimexpr\csname sdju@cont\the\sdju@i\endcsname
        *\sdju@spg/\sdju@tbspacing\relax}%
      \ifdim\sdju@tmpa<\csname sdju@labm\the\sdju@i\endcsname
        \setlength\sdju@tmpa{\csname sdju@labm\the\sdju@i\endcsname}\fi
      \addtolength\sdju@tmpb{\sdju@tmpa}}%
    \ifdim\sdju@tmpb<\sdju@fit \sdju@spnew=\sdju@spg \fi
    \sdju@spmorefalse
    \ifnum\sdju@spnew=\z@ \ifnum\sdju@spg>\sdju@spacingmin\relax \sdju@spmoretrue \fi\fi
  \ifsdju@spmore
    \advance\sdju@spg-\sdju@spacingstep\relax
  \repeat
  \ifnum\sdju@spnew=\z@ \sdju@spnew=\sdju@spacingmin\relax \fi
  \ifdim\sdju@sumfloor<\sdju@fit\else
    % 本遍放不下：至少降一级（估算与本遍一致，一般不会用到）
    \ifnum\sdju@spnew<\sdju@tbspacing\relax\else
      \ifnum\sdju@tbspacing>\sdju@spacingmin\relax
        \sdju@spnew=\numexpr\sdju@tbspacing-\sdju@spacingstep\relax
      \fi
    \fi
    \ifnum\sdju@tbspacing>\sdju@spacingmin\relax\else
      \ClassWarningNoLine{sdjutaskbook}{任务书反面内容过多：正文行距已减到单倍，仍排不下一页，%
排到了第二页。请删减内容}%
    \fi
  \fi
  \immediate\write\@auxout{\gdef\noexpand\sdju@tbspacing{\the\sdju@spnew}}%
  \ifnum\sdju@spnew=\sdju@tbspacing\relax
    \typeout{sdjutaskbook: 任务书反面正文行距 \fpeval{\sdju@spnew/100} 倍}%
  \else
    \ClassWarningNoLine{sdjutaskbook}{任务书反面正文行距改为 \fpeval{\sdju@spnew/100} 倍%
（本遍 \fpeval{\sdju@tbspacing/100} 倍）。Rerun to get the line spacing right}%
  \fi}
\newcommand\sdju@closeform{%
  \sdju@closerow
  \ifsdju@formstarted
    \global\sdju@formstartedfalse
    \par
    \setbox\sdju@note\hbox{\fangsong\sdjufont{12bp}{15.6bp}以上各项由指导教师填写}%
    % 本页能给各栏目文字区的总高度
    \sdju@getavail
    \sdju@fit=\dimexpr\sdju@avail-\sdju@notegap-\dp\sdju@note
      -(2\sdju@pady+\sdju@rule)*(\sdju@nrows-1)\relax\relax
    \setlength\sdju@sumneed{\z@}\setlength\sdju@sumfloor{\z@}%
    \sdju@i=\z@
    \@whilenum\sdju@i<\sdju@nrows\do{\advance\sdju@i\@ne \sdju@rowdims
      \expandafter\xdef\csname sdju@cont\the\sdju@i\endcsname{\the\sdju@tmpa}%
      \expandafter\xdef\csname sdju@labm\the\sdju@i\endcsname{\the\sdju@labmin}%
      \addtolength\sdju@sumneed{\sdju@minh}\addtolength\sdju@sumfloor{\sdju@tmpb}}%
    \sdju@choosespacing
    \sdju@i=\z@
    \@whilenum\sdju@i<\sdju@nrows\do{\advance\sdju@i\@ne \sdju@rowdims
      % 留白按比例收缩：最小高度 = 下限 + 留白 × (可用 - 下限之和) / (需要 - 下限之和)
      \ifdim\sdju@sumneed>\sdju@fit \ifdim\sdju@sumfloor<\sdju@fit
        \sdju@minh=\dimexpr\sdju@tmpb+(\sdju@minh-\sdju@tmpb)
          *(\sdju@fit-\sdju@sumfloor)/(\sdju@sumneed-\sdju@sumfloor)\relax\relax
      \fi\fi
      \begingroup
      \setbox\sdju@body\box\csname sdju@rowbox\the\sdju@i\endcsname
      \global\setbox\sdju@label\box\csname sdju@rowlab\the\sdju@i\endcsname
      % 收缩后栏目变矮时，竖排栏目名的字距在输出时按栏目高度随之减小（\sdju@fitlabel）
      \ifnum\sdju@i=\sdju@nrows
        \sdju@reserve=\dimexpr\sdju@notegap+\dp\sdju@note\relax
      \fi
      \sdju@formrow{\sdju@minh+2\sdju@pady+\sdju@rule}%
      \endgroup}%
    \global\sdju@nrows=\z@
    \nobreak\nointerlineskip
    \hbox{\vrule height\sdju@notegap depth\z@ width\z@\copy\sdju@note}%
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
    \par\nointerlineskip
    \hbox{\vrule height\sdju@backtop depth\dimexpr\sdju@backgap-\sdju@rule/2\relax width\z@
      \kaishu\sdjufont{12bp}{15.6bp}任务书反面：}%
    \prevdepth=\z@
  \fi
  \IfNoValueTF{#2}
    {\ifcsname sdju@minh@#3\endcsname
       \edef\sdju@rowminh{\csname sdju@minh@#3\endcsname}%
     \else \def\sdju@rowminh{30mm}\fi}
    {\def\sdju@rowminh{#2}}%
  \sdju@setcw
  \sdju@makelabel[\sdju@labelpitchmin]{#3}% 字距在输出时按栏目高度确定
  \def\sdju@curlabel{#3}%
  \setcounter{subsection}{0}%
  \global\sdju@rowopentrue
  \setbox\sdju@body\vbox\bgroup\sdju@bodysetup}
% 栏目内的小标题：\subsection{…}，与正文同字体字号（四号仿宋）加粗，编号 1、2、3…；\subsection* 不编号
\RenewDocumentCommand\subsection{s m}{%
  \par\IfBooleanF{#1}{\stepcounter{subsection}}%
  \noindent{\bfseries\IfBooleanF{#1}{\arabic{subsection}\enspace}#2}\par\nobreak}

% 进度安排：\begin{schedule} \item{20XX年XX月--20XX年XX月}{工作内容} \end{schedule}
% 每项一段「时间段：工作内容」，与正文同样的段落格式（不缩进，转行回到左边，不设悬挂缩进）
\newenvironment{schedule}
  {\par\setlength\parindent{\sdju@bodyindent}%
   \def\item##1##2{\par ##1：##2\par}}
  {\par}

% ===============================================================
% 图表题注
%   栏目内容排在表格的格子里（盒子中），不能用浮动体；这里把 table、figure 环境改为不浮动、
%   就地排出（可选的位置参数 [htbp] 等被忽略），环境内照常用 \caption、\label，正文用 \ref 引用。
%   不在环境内时也可用 \sdjutablecaption{…}、\sdjufigurecaption{…}（即 \captionof{table}、
%   \captionof{figure}）。格式与学位论文模板（附件26）一致：表名在表正上方、图名在图正下方，
%   宋体小五号加粗，「表1 …」「图1 …」顺序编号；表格建议用三线表（booktabs，线粗 0.5 磅），
%   表内文字小四号、单倍行距，列多时可用 \sdjutablesize{10.5bp} 改为五号。
%   图表连同题注不会被拆到两页；上下各留 8 磅。
% ===============================================================
\RequirePackage{booktabs}
\RequirePackage{caption}
\DeclareCaptionFont{sdjucap}{\songti\sdjufont{9bp}{\sdju@grid}\bfseries}
\captionsetup{font=sdjucap,labelsep=space,justification=centering,singlelinecheck=false,hypcap=false}
\captionsetup[table]{position=top,skip=4bp}
\captionsetup[figure]{position=bottom,skip=6bp}
\renewcommand\tablename{表}
\renewcommand\figurename{图}
\renewcommand\thetable{\arabic{table}}
\renewcommand\thefigure{\arabic{figure}}
\newcommand\sdjutablefont{\sdjufont{12bp}{\sdju@grid}}
\newcommand\sdjutablesize[1]{\renewcommand\sdjutablefont{\sdjufont{#1}{\sdju@grid}}}
\newcommand\sdju@tablerules{%
  \renewcommand\arraystretch{1}%
  \setlength\heavyrulewidth{0.5bp}\setlength\lightrulewidth{0.5bp}}
\NewDocumentCommand\sdjutablecaption{o m}
  {\IfNoValueTF{#1}{\captionof{table}{#2}}{\captionof{table}[#1]{#2}}}
\NewDocumentCommand\sdjufigurecaption{o m}
  {\IfNoValueTF{#1}{\captionof{figure}{#2}}{\captionof{figure}[#1]{#2}}}
\newbox\sdju@floatbox
% 不浮动的图表：#1 类型（table / figure）
\newcommand\sdju@nonfloat[1]{%
  \par\addvspace{8bp}%
  \setbox\sdju@floatbox\vbox\bgroup
    \hsize=\linewidth \parindent=\z@ \centering
    \def\@captype{#1}%
    \ifx\@captype\sdju@tablecaptype \sdjutablefont\sdju@tablerules
    \else \sdjufont{12bp}{\sdju@grid}\fi}
\newcommand\sdju@endnonfloat{%
  \par\egroup
  \box\sdju@floatbox
  \addvspace{8bp}}
\def\sdju@tablecaptype{table}
\RenewDocumentEnvironment{table}{o}{\sdju@nonfloat{table}}{\sdju@endnonfloat}
\RenewDocumentEnvironment{figure}{o}{\sdju@nonfloat{figure}}{\sdju@endnonfloat}

\RequirePackage[hidelinks,unicode]{hyperref}
\graphicspath{{figures/}}

% ===============================================================
% 电子签名与签字日期（由系统在服务端编译时放入；学生、教师的源码中不使用这些命令）
%   编译目录中有 sdju-signatures.cfg 时，在类文件末尾（\begin{document} 之前）读入。配置文件中：
%     \sdju@signrole{<角色>}              启用该角色：在它的每个签字处放入 signatures/<角色>.png
%     \sdju@signdate{<角色>}{年}{月}{日}   该角色签字处的日期（填在「年 月 日」的空白处）
%   角色：student、supervisor、company_supervisor、dean、committee_chair、
%     committee_member-1、committee_member-2、…（从 1 起连续编号）、recorder
%   没有配置文件、或配置文件中没有声明某角色时，该签字处与原来完全相同（空白，待手签）；
%   signatures/ 中有图片而配置文件未声明的角色不起作用。签名图片按签字处的高度等比缩放、
%   宽度不超过签字处，底部压在签字线（没有签字线时为栏目文字的基线）上；图片排成零尺寸的盒子，
%   不改变分页、行数和其他任何位置。几人共用一个日期的（如答辩小组），取其中最晚的日期。
%   源码中已写了日期（如 \taskdate、\supervisordate）时以源码为准。
% ===============================================================
\newcommand\sdju@signrole[1]{\global\@namedef{sdju@sigon@#1}{}}
\newcommand\sdju@signdate[4]{\global\@namedef{sdju@sdate@#1}{{#2}{#3}{#4}}}
\newcommand\sdju@signdir{signatures/}
% \sdju@ifsign{角色}{有签名时}{没有时}
\newcommand\sdju@ifsign[3]{%
  \ifcsname sdju@sigon@#1\endcsname
    \IfFileExists{\sdju@signdir#1.png}{#2}{%
      \ClassWarningNoLine{sdjutaskbook}{配置文件声明了签名角色 #1，但找不到 \sdju@signdir#1.png，该处留空}#3}%
  \else #3\fi}
\newbox\sdju@sigbox
% 签名图片（零尺寸，参考点在签字处左端的签字线上）：#1 角色，#2 签字处宽度，#3 签名高度；
%   图片在签字处中水平居中
\newcommand\sdju@sign[3]{\sdju@ifsign{#1}{%
  \setbox\sdju@sigbox\hbox{\includegraphics[height=#3,width=#2,keepaspectratio]{\sdju@signdir#1.png}}%
  \smash{\rlap{\kern\dimexpr(#2-\wd\sdju@sigbox)/2\relax\box\sdju@sigbox}}}{}}
% 同上，图片靠签字处左端排（签字处没有下划线、紧接在栏目名之后时）
\newcommand\sdju@signleft[3]{\sdju@ifsign{#1}{%
  \smash{\rlap{\includegraphics[height=#3,width=#2,keepaspectratio]{\sdju@signdir#1.png}}}}{}}
% 答辩小组组员（committee_member-1、-2…）：从签字处左端起横向排列，间隔 #3；一行排不下时换到
%   下一行（向下，行距为签名高度加 #3）。#1 第一行的宽度，#5 以下各行的宽度（避开其右侧的日期），
%   #2 签名高度，#4 至多几行：行数超过 #4 时签名高度逐级缩小（每级 10%，最小为原来的一半），
%   直到排得下。零尺寸，参考点在第一行的基线上
\newcount\sdju@signn \newcount\sdju@signrows
\newdimen\sdju@signh \newdimen\sdju@signw
\newcommand\sdju@signmembers[5]{%
  \def\sdju@signwrest{#5}%
  \begingroup
  \sdju@signh=#2\relax
  \sdju@signbuild{#1}{#3}%
  \loop
    \@tempswafalse
    \ifnum\sdju@signrows>#4\relax \ifdim\sdju@signh>\dimexpr#2/2+1sp\relax \@tempswatrue \fi\fi
  \if@tempswa
    \sdju@signh=\dimexpr\sdju@signh-#2/10\relax
    \sdju@signbuild{#1}{#3}%
  \repeat
  \ifnum\sdju@signrows>\z@
    \smash{\rlap{\vtop{\offinterlineskip\unvbox\sdju@sigbox}}}%
  \fi
  \endgroup}
% 按高度 \sdju@signh 把组员签名排成若干行，放在 \sdju@sigbox，行数在 \sdju@signrows
\newcommand\sdju@signbuild[2]{%
  \setbox\sdju@sigbox\vbox{}\setbox\z@\hbox{}\sdju@signrows=\z@ \sdju@signn=\@ne
  \def\sdju@signrow{% 把当前一行（\box\z@）接到已排的各行之下
    \setbox\sdju@sigbox\vbox{\offinterlineskip\unvbox\sdju@sigbox
      \ifnum\sdju@signrows>\z@ \kern#2\fi \box\z@}%
    \advance\sdju@signrows\@ne}%
  \sdju@signbuild@i{#1}{#2}%
  \ifdim\wd\z@>\z@ \sdju@signrow \fi}
\newcommand\sdju@signbuild@i[2]{%
  \ifcsname sdju@sigon@committee_member-\the\sdju@signn\endcsname
    \sdju@ifsign{committee_member-\the\sdju@signn}{%
      \ifnum\sdju@signrows=\z@ \sdju@signw=#1\relax \else \sdju@signw=\sdju@signwrest\relax \fi
      \setbox\tw@\hbox{\includegraphics[height=\sdju@signh,width=\sdju@signw,keepaspectratio]%
        {\sdju@signdir committee_member-\the\sdju@signn.png}}%
      \ifdim\wd\z@>\z@
        \ifdim\dimexpr\wd\z@+#2+\wd\tw@\relax>\sdju@signw
          \sdju@signrow \setbox\z@\hbox{\box\tw@}%
        \else \setbox\z@\hbox{\unhbox\z@\kern#2\box\tw@}\fi
      \else \setbox\z@\hbox{\box\tw@}\fi}{}%
    \advance\sdju@signn\@ne
    \expandafter\sdju@signbuild@i
  \else \expandafter\@gobbletwo
  \fi{#1}{#2}}
% 答辩小组全体（组长与组员）的角色列表，用于取共用的日期
\newcommand\sdju@committeeroles{committee_chair,committee_member-1,committee_member-2,committee_member-3,committee_member-4,committee_member-5,committee_member-6,committee_member-7,committee_member-8,committee_member-9,committee_member-10,committee_member-11,committee_member-12,committee_member-13,committee_member-14,committee_member-15,committee_member-16,committee_member-17,committee_member-18,committee_member-19,committee_member-20}
% 日期：\sdju@getdate{角色,角色,…} 取这些角色中最晚的日期，放在 \sdju@dy、\sdju@dm、\sdju@dd
%   （没有时为空，\ifsdju@hasdate 为假）
\newif\ifsdju@hasdate
\newcount\sdju@dbest \newcount\sdju@dcur
\newcommand\sdju@getdate[1]{%
  \global\sdju@hasdatefalse \sdju@dbest=\m@ne
  \gdef\sdju@dy{}\gdef\sdju@dm{}\gdef\sdju@dd{}%
  \@for\sdju@r:=#1\do{%
    \ifcsname sdju@sdate@\sdju@r\endcsname
      \expandafter\expandafter\expandafter\sdju@getdate@i\csname sdju@sdate@\sdju@r\endcsname
    \fi}}
\newcommand\sdju@getdate@i[3]{%
  \sdju@dcur=\numexpr(#1)*10000+(#2)*100+(#3)\relax
  \ifnum\sdju@dcur>\sdju@dbest
    \sdju@dbest=\sdju@dcur \global\sdju@hasdatetrue
    \gdef\sdju@dy{#1}\gdef\sdju@dm{#2}\gdef\sdju@dd{#3}%
  \fi}
% 「年 月 日」填入日期：#1 角色列表，#2「年」前空白的宽度（年份右对齐写在其中；为 0 时年份写在
%   「年」左侧之外，不占宽度），#3、#4「月」「日」前空白的宽度（月、日在其中居中）。没有日期时
%   与原来的「年\hspace{#3}月\hspace{#4}日」相同。数字放在 \hbox 中（不用 \makebox：xeCJK 会在
%   汉字与 \makebox 之间加中西文间距，使「月」「日」右移），填入日期后「年」「月」「日」的位置不变
\newcommand\sdju@datefill[4]{%
  \sdju@getdate{#1}%
  \ifsdju@hasdate
    \ifdim#2=\z@ \llap{\sdju@dy}\else \hbox to#2{\hss\sdju@dy}\fi
    年\hbox to#3{\hss\sdju@dm\hss}月\hbox to#4{\hss\sdju@dd\hss}日%
  \else
    \ifdim#2=\z@\else\hspace{#2}\fi 年\hspace{#3}月\hspace{#4}日%
  \fi}
\InputIfFileExists{sdju-signatures.cfg}{}{}
\endinput
