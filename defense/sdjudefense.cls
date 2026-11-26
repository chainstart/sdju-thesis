%% sdjudefense.cls
%% 上海电机学院 本科生毕业设计（论文）答辩记录表 LaTeX 模板
%% 依据：《教学归档材料及质量评价要素（2026 版）》附件31《本科生毕业设计（论文）答辩记录表》；
%%       3.1 归档目录 (9)(10)(11)：开题答辩、中期检查答辩、毕业设计（论文）答辩各一份，模板同为附件31；
%%       3.3.5 答辩记录：一问一答、只记问题不记评价、回答详细记录、由答辩组成员填写（不得由学生填写）。
%%
%% 行距约定：「单倍行距」= 15.6bp，「1.25 倍」= 19.5bp。
%% 编译：xelatex（或直接 latexmk defense.tex）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjudefense}[2026/11/25 v1.0 SDJU Defense Record Template]

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
\RequirePackage{enumitem}

% ===============================================================
% 字体：宋体 / 黑体 / Times New Roman；找不到时用 Fandol / TeX Gyre Termes
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
  \IfFontExistsTF{FangSong}{\setCJKfamilyfont{zhfs}{FangSong}[AutoFakeBold=\sdju@fakebold]}{\setCJKfamilyfont{zhfs}{SimSun}[AutoFakeBold=\sdju@fakebold]}
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
\ExplSyntaxOn
\NewDocumentCommand\sdjuspacing{m}
  {\fontsize{\f@size}{\fp_eval:n{#1*15.6}bp}\selectfont}
\ExplSyntaxOff

% 断行：与 Word 一致，英文单词不用连字符拆开；排不下时放宽词距
\hyphenpenalty=10000
\tolerance=1000
\setlength{\emergencystretch}{3em}

% 编号列表（各模板统一）：全角括号「（1）」「（2）」…，编号后紧接内容（全角括号自带半字空白），
%   首行与正文同样缩进 \sdju@listindent，转行回到左边。依据与取舍见 README「编号列表」
\newcommand\sdju@listindent{2em}
\setlist{nosep}
\setlist[enumerate,1]{label=（\arabic*）,leftmargin=0pt,labelindent=\sdju@listindent,
  itemindent=*,labelsep=0pt,align=left,listparindent=\sdju@listindent}
\setlist[itemize,1]{leftmargin=0pt,labelindent=\sdju@listindent,itemindent=*,
  labelsep=0.5em,listparindent=\sdju@listindent}

% ===============================================================
% 页面：A4；上、下 2.54cm，左、右 3.17cm（90 磅）；不印页眉页脚和页码（附件31 的表格本身没有页码）
% ===============================================================
\geometry{a4paper,top=72bp,bottom=72bp,left=90bp,right=90bp,
  headheight=0pt,headsep=0pt,footskip=0pt}
\pagestyle{empty}
\raggedbottom

% ===============================================================
% 信息（表头各栏）
%   \title{题目} \author{姓名} \studentid{学号} \major{专业} \classname{班级}
%   \defensetype{proposal | midterm | thesis}：答辩类型，三选一勾选
%     （也可写「开题答辩」「中期检查答辩」「毕业设计（论文）答辩」）
%   \committee{专家组成员}：答辩组成员姓名，顿号分隔
%   \recorder{记录人}、\recorddate{20XX 年 XX 月 XX 日}：不写时留空，打印后手写
% ===============================================================
\newcommand\sdju@title{}
\newcommand\sdju@author{}
\newcommand\sdju@studentid{}
\newcommand\sdju@major{}
\newcommand\sdju@classname{}
\newcommand\sdju@committee{}
\newcommand\sdju@recorder{}
\newcommand\sdju@recorddate{}
\newcommand\sdju@typeproposal{0}
\newcommand\sdju@typemidterm{0}
\newcommand\sdju@typethesis{0}
\renewcommand\title[1]{\renewcommand\sdju@title{#1}}
\renewcommand\author[1]{\renewcommand\sdju@author{#1}}
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\newcommand\major[1]{\renewcommand\sdju@major{#1}}
\newcommand\classname[1]{\renewcommand\sdju@classname{#1}}
\newcommand\committee[1]{\renewcommand\sdju@committee{#1}}
\newcommand\recorder[1]{\renewcommand\sdju@recorder{#1}}
\newcommand\recorddate[1]{\renewcommand\sdju@recorddate{#1}}
\newcommand\defensetype[1]{%
  \renewcommand\sdju@typeproposal{0}\renewcommand\sdju@typemidterm{0}\renewcommand\sdju@typethesis{0}%
  \def\sdju@arg{#1}%
  \ifboolexpr{test{\ifdefstring\sdju@arg{proposal}} or test{\ifdefstring\sdju@arg{开题答辩}}}
    {\renewcommand\sdju@typeproposal{1}}{%
  \ifboolexpr{test{\ifdefstring\sdju@arg{midterm}} or test{\ifdefstring\sdju@arg{中期检查答辩}}}
    {\renewcommand\sdju@typemidterm{1}}{%
  \ifboolexpr{test{\ifdefstring\sdju@arg{thesis}} or test{\ifdefstring\sdju@arg{毕业设计（论文）答辩}}}
    {\renewcommand\sdju@typethesis{1}}{%
  \ifdefempty\sdju@arg{}{\ClassWarningNoLine{sdjudefense}{答辩类型「#1」无法识别，应为 proposal、midterm 或 thesis}}}}}}
% 方框：\sdju@checkbox{1} 打勾，\sdju@checkbox{0} 空
\newcommand\sdju@checkbox[1]{%
  \ifnum#1=1 \makebox[0pt][l]{□}\makebox[1em]{\raisebox{0.08em}{\fontsize{0.8\dimexpr\f@size pt\relax}{0pt}\selectfont √}}%
  \else □\fi}

% ===============================================================
% 表格（尺寸按 2026 版附件31 量取）
%   行高为相邻两条横线中心之间的距离。
%   表格宽 428.9 磅（含两侧边线），左边线伸出版心左边 5.8 磅；线粗均为 0.48 磅（原件为细实线，外框不加粗）。
%   列宽（相邻竖线中心之间）104.65 | 161.65 | 67.5 | 余下（94.6），与 Word 模板的 2093/3233/1350/1892 缇一致；
%   单元格左右内边距 5.4 磅；表格文字小四号宋体，行框 19.6 磅，文字在行框中上下居中
%   （基线在行框中心下 0.359 个字高，与 Word 中宋体的位置一致）。
%   行高：姓名 24、专业 28.1、毕业设计（论文）题目 39.5、答辩类型 31.5、专家组成员 31.4 磅；
%   答辩记录大格最小高度 483.5 磅，内容多时自动加高、跨页，「记录人」与「年 月 日」总在大格底部。
% ===============================================================
\newlength\sdju@formw      \setlength\sdju@formw{428.9bp}
\newlength\sdju@formshift  \setlength\sdju@formshift{-5.8bp}
\newlength\sdju@rule       \setlength\sdju@rule{0.48bp}
\newlength\sdju@padx       \setlength\sdju@padx{5.4bp}
\newlength\sdju@pady       \setlength\sdju@pady{2bp}
\newlength\sdju@cw
% 表格文字的支柱：行高 19.6 磅，基线在行框中心下 0.359 个字高（12 磅字为 4.3 磅）
\def\sdju@emcenter{0.359}
\newcommand\sdju@cellstrut{%
  \vrule width\z@ height\dimexpr\baselineskip/2+\sdju@emcenter\dimexpr\f@size pt\relax\relax
    depth\dimexpr\baselineskip/2-\sdju@emcenter\dimexpr\f@size pt\relax\relax}
\newlength\sdju@avail \newlength\sdju@minh \newlength\sdju@tmpa
\newlength\sdju@used \newlength\sdju@axis
\newbox\sdju@body \newbox\sdju@tail \newbox\sdju@piece
% ---- 不可跨页的表格行 ----
\newcommand\sdju@align@l{\raggedright}
\newcommand\sdju@align@c{\centering}
\newcommand\sdju@cellbox[3]{%
  \hbox to\dimexpr#1-\sdju@rule\relax{\hskip\sdju@padx
    $\vcenter{\hsize=\dimexpr#1-\sdju@rule-2\sdju@padx\relax \linewidth=\hsize
      \parindent=\z@ \csname sdju@align@#2\endcsname
      \kern-.5\sdju@rule\sdju@cellstrut#3\sdju@cellstrut\par\kern-.5\sdju@rule}$%
    \hss}}
\newcommand\sdju@cell[3]{%
  \sdju@cellbox{#1}{#2}{#3}\vrule width\sdju@rule \addtolength\sdju@used{#1}}
\newcommand\sdju@lastcell[2]{%
  \sdju@cellbox{\dimexpr\sdju@formw-\sdju@rule-\sdju@used\relax}{#1}{#2}}
\newcommand\sdju@row[2]{%
  \par\nointerlineskip
  \moveright\sdju@formshift\vbox{%
    \hrule height\sdju@rule width\sdju@formw
    \hbox to\sdju@formw{\setlength\sdju@used{\z@}\setbox\z@\hbox{$\vcenter{}$}\sdju@axis=\ht\z@%
      \vrule width\sdju@rule
      \vrule width\z@ height\dimexpr(#1-\sdju@rule)/2+\sdju@axis\relax depth\dimexpr(#1-\sdju@rule)/2-\sdju@axis\relax
      #2\vrule width\sdju@rule}%
    \hrule height\sdju@rule width\sdju@formw}%
  \kern-\sdju@rule\prevdepth=\z@}
% ---- 可跨页的「答辩记录」大格 ----
\newcommand\sdju@bodysetup{%
  \hsize=\sdju@cw \linewidth=\hsize \columnwidth=\hsize \@totalleftmargin=\z@
  \normalfont\normalsize\parindent=2em \parskip=\z@
  \everypar{}}
\newcommand\sdju@outpiece[1]{%
  \nointerlineskip
  \moveright\sdju@formshift\vbox{%
    \hrule height\sdju@rule width\sdju@formw
    \hbox to\sdju@formw{%
      \vrule width\sdju@rule
      \hskip\sdju@padx
      \vbox to\dimexpr#1+2\sdju@pady\relax{\hsize=\sdju@cw
        \vskip\sdju@pady\box\sdju@piece\vss}%
      \hfil\vrule width\sdju@rule}%
    \hrule height\sdju@rule width\sdju@formw}%
  \kern-\sdju@rule\prevdepth=\z@}
\newcommand\sdju@getavail{%
  \par\penalty\@M
  \ifdim\pagegoal=\maxdimen \setlength\sdju@avail{\vsize}%
  \else \setlength\sdju@avail{\pagegoal-\pagetotal}\fi
  \addtolength\sdju@avail{-2\sdju@pady-2\sdju@rule}}
\newcommand\sdju@formrow[1]{%
  \par
  \setlength\sdju@minh{#1}%
  \addtolength\sdju@minh{-2\sdju@pady-\sdju@rule}% 行高按横线中心计，上下两条线各算一半
  \setbox\sdju@body\vbox{\unvbox\sdju@body
    \ifvoid\sdju@tail\else \par\nobreak\vskip 12bp plus 1fill \box\sdju@tail\fi}% 记录人栏不单独落到下一页
  \setlength\sdju@tmpa{\ht\sdju@body+\dp\sdju@body}%
  \sdju@getavail
  \ifdim\sdju@avail<40mm \ifdim\sdju@tmpa>\sdju@avail
    \newpage\sdju@getavail \fi\fi
  \ifdim\sdju@tmpa<\sdju@minh
    \ifdim\sdju@minh>\sdju@avail \setlength\sdju@minh{\sdju@avail}\fi
    \setbox\sdju@body\vbox to\sdju@minh{\unvbox\sdju@body\vfil}%
    \setlength\sdju@tmpa{\sdju@minh}%
  \fi
  \splittopskip=14bp \splitmaxdepth=\maxdimen \vbadness=\@M
  \loop
    \ifdim\sdju@tmpa>\sdju@avail
      \setbox\sdju@piece\vsplit\sdju@body to\sdju@avail
      \sdju@outpiece{\sdju@avail}%
      \newpage\sdju@getavail
      \setlength\sdju@tmpa{\ht\sdju@body+\dp\sdju@body}%
  \repeat
  \setbox\sdju@piece\box\sdju@body
  \sdju@outpiece{\sdju@tmpa}%
  \global\setbox\sdju@tail\box\voidb@x}
% 大格底部：「记录人：」左端距表格右边线 177.2 磅；下一行「年 月 日」，「日」右侧距表格右边线约 57 磅；
% 日期行基线到表格底线 25.3 磅（附件31）
\newcommand\sdju@recordtail{%
  \global\setbox\sdju@tail\vbox{\hsize=\sdju@cw \parindent=\z@
    \normalfont\sdjufont{12bp}{21bp}%
    \hbox to\hsize{\hfil\hbox to\dimexpr177.2bp-\sdju@padx-\sdju@rule\relax{记录人：\sdju@recorder\hfil}}%
    \hbox to\hsize{\hfil
      \ifx\sdju@recorddate\@empty 年\hspace{2em}月\hspace{2em}日\else\sdju@recorddate\fi
      \hspace{\dimexpr57.2bp-\sdju@padx-\sdju@rule\relax}}%
    \kern 21bp}}

% ===============================================================
% 标题与表头：\maketitle
%   「本科生毕业设计（论文）答辩记录表」小三号黑体加粗（15 磅，附件31 为描边加粗）居中，基线距纸边上沿 93.1 磅；
%   表头五行：姓名 | 学号、专业 | 班级、毕业设计（论文）题目、答辩类型、专家组成员，栏目名居中
% ===============================================================
\renewcommand\maketitle{%
  \par
  \begingroup
  \centering\heiti\bfseries\sdjufont{15bp}{15bp}%
  \vspace*{\dimexpr6.1bp-\topskip\relax}%
  本科生毕业设计（论文）答辩记录表\par
  \endgroup
  \kern-\prevdepth\vskip 10.06bp% 表格上边线顶端在标题基线下 10.06 磅（线中心 10.3 磅），不受标题字体深度影响
  \begingroup
  \normalfont\sdjufont{12bp}{19.6bp}%
  \sdju@row{24bp}{%
    \sdju@cell{104.65bp}{c}{姓名}\sdju@cell{161.65bp}{c}{\sdju@author}%
    \sdju@cell{67.5bp}{c}{学号}\sdju@lastcell{c}{\sdju@studentid}}%
  \sdju@row{28.1bp}{%
    \sdju@cell{104.65bp}{c}{专业}\sdju@cell{161.65bp}{c}{\sdju@major}%
    \sdju@cell{67.5bp}{c}{班级}\sdju@lastcell{c}{\sdju@classname}}%
  \sdju@row{39.5bp}{%
    \sdju@cell{104.65bp}{c}{\makebox[\linewidth][l]{毕业设计（论文）}\\题目}\sdju@lastcell{l}{\sdju@title}}%
  \sdju@row{31.5bp}{%
    \sdju@cell{104.65bp}{c}{答辩类型}%
    \sdju@lastcell{l}{\sdju@checkbox{\sdju@typeproposal}开题答辩\hspace{1em}%
      \sdju@checkbox{\sdju@typemidterm}中期检查答辩\hspace{1em}%
      \sdju@checkbox{\sdju@typethesis}毕业设计（论文）答辩}}%
  \sdju@row{31.4bp}{%
    \sdju@cell{104.65bp}{c}{专家组成员}\sdju@lastcell{l}{\sdju@committee}}%
  \endgroup}

% ===============================================================
% 答辩记录：\section{答辩记录}
%   写在一个通栏的大格里：首行「答辩记录：」，其后为一问一答（3.3.5(3)）：
%     \question{问题}   →「问：……」（栏目名加粗，内容小四号宋体，1.25 倍行距）
%     \answer{回答}     →「答：……」
%   栏目写到文档结束为止；最小高度 483.5 磅（附件31），可用可选参数改：\section[120mm]{答辩记录}。
% ===============================================================
\newif\ifsdju@rowopen
\newcommand\sdju@rowminh{483.5bp}
\newcommand\sdju@closerow{%
  \ifsdju@rowopen
    \par\egroup
    \global\sdju@rowopenfalse
    \sdju@formrow{\sdju@rowminh}%
  \fi}
\AtEndDocument{\sdju@closerow}
\RenewDocumentCommand\section{s o m}{%
  \sdju@closerow
  \IfNoValueTF{#2}{\def\sdju@rowminh{483.5bp}}{\def\sdju@rowminh{#2}}%
  \setlength\sdju@cw{\sdju@formw-2\sdju@rule-2\sdju@padx}%
  \sdju@recordtail
  \global\sdju@rowopentrue
  \setbox\sdju@body\vbox\bgroup\sdju@bodysetup
    \vskip 5.6bp{\parindent=\z@ \noindent #3：\par}}
\newcommand\sdju@qa[2]{%
  \par\indent{\bfseries #1：}\ignorespaces#2\par}
\newcommand\question[1]{\sdju@qa{问}{#1}}
\newcommand\answer[1]{\sdju@qa{答}{#1}}

\RequirePackage[hidelinks,unicode]{hyperref}
\endinput
