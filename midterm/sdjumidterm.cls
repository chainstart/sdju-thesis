%% sdjumidterm.cls
%% 上海电机学院 毕业设计（论文）中期检查报告 LaTeX 模板
%% 依据：《教学归档材料及质量评价要素（2026 版）》附件24《毕业设计（论文）中期检查报告》
%%
%% 行距约定：「单倍行距」= 15.6bp，「1.25 倍」= 19.5bp。
%% 编译：xelatex（或直接 latexmk midterm.tex）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjumidterm}[2026/11/20 v1.0 SDJU Midterm Report Template]

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
% 字体：宋体 / 黑体 / Times New Roman；找不到时用 Fandol / TeX Gyre Termes
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
% 页面：A4；上、下 2.54cm，左、右 3.17cm（90 磅）；不印页眉页脚和页码（附件24 的表格本身没有页码）
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
\newcommand\sdju@projectsource{}
\newcommand\sdju@changereason{}
\newcommand\sdju@changeno{0}\newcommand\sdju@changeyes{0}
\renewcommand\title[1]{\renewcommand\sdju@title{#1}}
\newcommand\school[1]{\renewcommand\sdju@school{#1}}
\newcommand\major[1]{\renewcommand\sdju@major{#1}}
\newcommand\classname[1]{\renewcommand\sdju@classname{#1}}% 附件24 没有「班级」栏，只记录不印出
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\renewcommand\author[1]{\renewcommand\sdju@author{#1}}
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}% 校内指导教师
\newcommand\companysupervisor[1]{\renewcommand\sdju@companysupervisor{#1}}% 企业指导教师
\newcommand\projectsource[1]{\renewcommand\sdju@projectsource{#1}}% 课题来源/项目编号
% 课题有无变化：\topicchange{无}，或 \topicchange[变化原因]{有}；不写则两个方框都不勾
\NewDocumentCommand\topicchange{o m}{%
  \ifstrequal{#2}{有}
    {\renewcommand\sdju@changeyes{1}\renewcommand\sdju@changeno{0}}
    {\renewcommand\sdju@changeno{1}\renewcommand\sdju@changeyes{0}}%
  \IfNoValueTF{#1}{}{\renewcommand\sdju@changereason{#1}}}
% 方框：\sdju@checkbox{1} 打勾，\sdju@checkbox{0} 空
\newcommand\sdju@checkbox[1]{%
  \ifnum#1=1 \makebox[0pt][l]{□}\makebox[1em]{\raisebox{0.08em}{\fontsize{0.8\dimexpr\f@size pt\relax}{0pt}\selectfont √}}%
  \else □\fi}

% ===============================================================
% 表格
%   表格宽 427.5 磅，左边线伸出版心左边 6.1 磅；左右外框线 1 磅，表格首尾横线 1 磅，其余线 0.5 磅。
%   单元格左右内边距 1.4 磅；表格文字小四号宋体。
%   \sdju@row{最小行高}{单元格…}：一行不可跨页的表格行，各单元格内容上下居中；
%     \sdju@cell{宽度}{对齐 l/c/r}{内容}（宽度含其右侧竖线），最后一格用 \sdju@lastcell{对齐}{内容} 占满余下宽度。
%   \sdju@formrow：可跨页的大栏目（中期报告、指导教师意见），内容写不下时在页底断开、下一页接着排；
%     内容少时按「最小高度」留白（取自附件24 各栏的高度），签名栏排在栏目底部。
% ===============================================================
\newlength\sdju@formw      \setlength\sdju@formw{427.5bp}%  表格总宽
\newlength\sdju@formshift  \setlength\sdju@formshift{-6.1bp}% 表格左边线相对版心左边的位移
\newlength\sdju@rule       \setlength\sdju@rule{0.5bp}%     内框线
\newlength\sdju@orule      \setlength\sdju@orule{1bp}%      外框线
\newlength\sdju@labelw     \setlength\sdju@labelw{0pt}%     （本表的大栏目没有竖排栏目名）
\newlength\sdju@padx       \setlength\sdju@padx{1.4bp}%     单元格左右内边距
\newlength\sdju@pady       \setlength\sdju@pady{2bp}%       单元格上下内边距
\newlength\sdju@cw         % 内容格中文字的宽度
\newlength\sdju@avail \newlength\sdju@minh \newlength\sdju@tmpa
\newlength\sdju@used \newlength\sdju@axis
\newbox\sdju@body \newbox\sdju@tail \newbox\sdju@piece \newbox\sdju@label
\newif\ifsdju@firstpiece
% ---- 不可跨页的表格行 ----
\newcommand\sdju@align@l{\raggedright}
\newcommand\sdju@align@c{\centering}
\newcommand\sdju@align@r{\raggedleft}
\newcommand\sdju@cellbox[3]{%
  \hbox to\dimexpr#1-\sdju@rule\relax{\hskip\sdju@padx
    $\vcenter{\hsize=\dimexpr#1-\sdju@rule-2\sdju@padx\relax \linewidth=\hsize
      \parindent=\z@ \csname sdju@align@#2\endcsname \strut#3\strut\par}$%
    \hss}}
\newcommand\sdju@cell[3]{%
  \sdju@cellbox{#1}{#2}{#3}\vrule width\sdju@rule \addtolength\sdju@used{#1}}
\newcommand\sdju@lastcell[2]{%
  \sdju@cellbox{\dimexpr\sdju@formw-2\sdju@orule-\sdju@used+\sdju@rule\relax}{#1}{#2}}
\newcommand\sdju@row[2]{%
  \par\nointerlineskip
  \moveright\sdju@formshift\vbox{%
    \hrule height\sdju@rule width\sdju@formw
    \hbox to\sdju@formw{\setlength\sdju@used{\z@}\setbox\z@\hbox{$\vcenter{}$}\sdju@axis=\ht\z@%
      \vrule width\sdju@orule
      \vrule width\z@ height\dimexpr#1/2+\sdju@axis\relax depth\dimexpr#1/2-\sdju@axis\relax
      #2\vrule width\sdju@orule}%
    \hrule height\sdju@rule width\sdju@formw}%
  \kern-\sdju@rule\prevdepth=\z@}
% 表格首尾的粗横线（1 磅），与相邻行的细线重叠
\newcommand\sdju@thickrule{%
  \par\nointerlineskip
  \moveright\sdju@formshift\vbox{\hrule height\sdju@orule width\sdju@formw}%
  \kern-\sdju@orule\prevdepth=\z@}
% ---- 可跨页的大栏目 ----
\newcommand\sdju@setcw{%
  \setlength\sdju@cw{\sdju@formw-2\sdju@orule-2\sdju@padx}%
  \ifdim\sdju@labelw>\z@ \addtolength\sdju@cw{-\sdju@labelw}\fi}
\newcommand\sdju@bodysetup{%
  \hsize=\sdju@cw \linewidth=\hsize \columnwidth=\hsize \@totalleftmargin=\z@
  \normalfont\normalsize\parindent=2em \parskip=\z@
  \everypar{}}
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
\newcommand\sdju@getavail{%
  \par\penalty\@M
  \ifdim\pagegoal=\maxdimen \setlength\sdju@avail{\vsize}%
  \else \setlength\sdju@avail{\pagegoal-\pagetotal}\fi
  \addtolength\sdju@avail{-2\sdju@pady-2\sdju@rule}}
\newcommand\sdju@formrow[1]{%
  \par
  \setlength\sdju@minh{#1}%
  \addtolength\sdju@minh{-2\sdju@pady-2\sdju@rule}%
  \ifvoid\sdju@label\else
    \ifdim\sdju@minh<\ht\sdju@label \setlength\sdju@minh{\ht\sdju@label}\fi
  \fi
  \setbox\sdju@body\vbox{\unvbox\sdju@body
    \ifvoid\sdju@tail\else \par\vskip 6bp plus 1fill \box\sdju@tail\fi}%
  \setlength\sdju@tmpa{\ht\sdju@body+\dp\sdju@body}%
  \sdju@getavail
  \ifdim\sdju@avail<40mm \ifdim\sdju@tmpa>\sdju@avail
    \newpage\sdju@getavail \fi\fi
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
% 签名栏：#1 签名人（如「学生签名」）；签名下划线 84 磅，下一行「年 月 日」，均靠右
\newcommand\sdju@signature[1]{%
  \global\setbox\sdju@tail\vbox{\hsize=\sdju@cw \parindent=\z@
    \normalfont\sdjufont{12bp}{19.5bp}%
    \hbox to\hsize{\hfil#1：\rule[-1.6bp]{84bp}{0.6bp}}%
    \hbox to\hsize{\hfil 年\hspace{2em}月\hspace{2em}日\hspace{3em}}\kern 4bp}}

% ===============================================================
% 标题与基本信息表（附件24 第 1 页上部）：\maketitle
%   「上 海 电 机 学 院」三号黑体，字距 0.5 字；「本科生毕业设计（论文）中期检查报告」三号黑体加粗；
%   均居中，固定行距 20 磅，段后 7.8 磅
%   基本信息表：行高 25.5 磅；前三行四格（栏目名加粗居中），后三行两格（栏目名左对齐）
% ===============================================================
\renewcommand\maketitle{%
  \par
  \begingroup
  \centering\heiti\sdjufont{16bp}{20bp}%
  上\hspace{0.5em}海\hspace{0.5em}电\hspace{0.5em}机\hspace{0.5em}学\hspace{0.5em}院\par
  {\bfseries 本科生毕业设计（论文）中期检查报告\par}%
  \endgroup
  \vskip 7.8bp
  \begingroup
  \normalfont\sdjufont{12bp}{15.6bp}%
  \def\sdju@lab##1{{\bfseries##1}}%
  \sdju@thickrule
  \sdju@row{25.5bp}{%
    \sdju@cell{76.3bp}{c}{\sdju@lab{姓\hspace{1em}名}}\sdju@cell{91.2bp}{c}{\sdju@author}%
    \sdju@cell{100.1bp}{c}{\sdju@lab{学\hspace{1em}号}}\sdju@lastcell{c}{\sdju@studentid}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{76.3bp}{c}{\sdju@lab{校内指导教师}}\sdju@cell{91.2bp}{c}{\sdju@supervisor}%
    \sdju@cell{100.1bp}{c}{\sdju@lab{企业指导教师}}\sdju@lastcell{c}{\sdju@companysupervisor}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{76.3bp}{c}{\sdju@lab{专\hspace{1em}业}}\sdju@cell{91.2bp}{c}{\sdju@major}%
    \sdju@cell{100.1bp}{c}{\sdju@lab{学\hspace{1em}院}}\sdju@lastcell{c}{\sdju@school}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{111.3bp}{l}{{\def\CJKecglue{}毕业设计(论文)题目}}\sdju@lastcell{l}{\sdju@title}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{111.3bp}{l}{课题来源/项目编号}\sdju@lastcell{l}{\sdju@projectsource}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{111.3bp}{l}{课题有无变化}%
    \sdju@lastcell{l}{\sdju@checkbox{\sdju@changeno}无\hspace{1em}\sdju@checkbox{\sdju@changeyes}有\hspace{1em}%
      变化原因\ifx\sdju@changereason\@empty\else：\sdju@changereason\fi}}%
  \endgroup}

% ===============================================================
% 正文栏目：\section{中期报告}
%   写在一个通栏的大格里：首行为栏目名及附件24 中的说明
%   「中期报告（已完成的研究内容，所取得阶段性成果，下一步工作计划和研究内容等）」，
%   下面是正文（小四号宋体，1.25 倍行距，首行缩进 2 字符），栏目底部为「学生签名：____ 年 月 日」。
%   栏目写到下一个 \section、\supervisoropinion 或文档结束为止；最小高度 457.3 磅（附件24 的行高），
%   可用可选参数改：\section[120mm]{中期报告}。内容写不下时自动跨页。
%   栏目内的小标题用 \subsection{…}（小四号宋体加粗，编号 1、2、3…）。
% ===============================================================
\@namedef{sdju@hint@中期报告}{（已完成的研究内容，所取得阶段性成果，下一步工作计划和研究内容等）}
\@namedef{sdju@minh@中期报告}{457.3bp}
\@namedef{sdju@sign@中期报告}{学生签名}
\newif\ifsdju@rowopen
\newcommand\sdju@rowminh{60mm}
\newcommand\sdju@closerow{%
  \ifsdju@rowopen
    \par\egroup
    \global\sdju@rowopenfalse
    \sdju@formrow{\sdju@rowminh}%
    \sdju@thickrule
  \fi}
\AtEndDocument{\sdju@closerow}
\RenewDocumentCommand\section{s o m}{%
  \sdju@closerow
  \IfNoValueTF{#2}
    {\ifcsname sdju@minh@#3\endcsname
       \edef\sdju@rowminh{\csname sdju@minh@#3\endcsname}%
     \else \def\sdju@rowminh{60mm}\fi}
    {\def\sdju@rowminh{#2}}%
  \sdju@setcw
  \global\setbox\sdju@label\box\voidb@x
  \ifcsname sdju@sign@#3\endcsname
    \sdju@signature{\csname sdju@sign@#3\endcsname}%
  \else \global\setbox\sdju@tail\box\voidb@x \fi
  \setcounter{subsection}{0}%
  \global\sdju@rowopentrue
  \setbox\sdju@body\vbox\bgroup\sdju@bodysetup
    {\parindent=\z@ \noindent #3\ifcsname sdju@hint@#3\endcsname\csname sdju@hint@#3\endcsname\fi\par}}
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

% ===============================================================
% 意见页（附件24 第 2 页）
%   \supervisoropinion{<意见内容，可留空>}：另起一页；通栏大格，首行「指导教师意见：」，
%     底部「指导教师签名：____ 年 月 日」；最小高度 254.2 磅，内容多时自动加高、跨页。
%   \committeeconclusion{<建议内容，可留空>}：答辩小组结论，接在指导教师意见之后，高 411.7 磅（不跨页，
%     本页放不下时移到下一页）。左格竖排「答辩/小组/结论」（五号，每行两字）；
%     右格上部「建议：」，下部为答辩结论（通过□ 不通过□）、等第评定（优秀□ 良好□ 及格□）、
%     答辩小组组长签名、答辩小组组员签名、年 月 日，行距 31.2 磅。
% ===============================================================
\newcommand\supervisoropinion[1]{%
  \sdju@closerow
  \clearpage
  \sdju@setcw
  \global\setbox\sdju@label\box\voidb@x
  \sdju@signature{指导教师签名}%
  \setbox\sdju@body\vbox{\sdju@bodysetup
    {\parindent=\z@ \noindent 指导教师意见：\par}#1\par}%
  \sdju@thickrule
  \sdju@formrow{254.2bp}}
\newlength\sdju@cclabelw \setlength\sdju@cclabelw{33.7bp}% 「答辩小组结论」格宽（含其右侧竖线）
\newcommand\sdju@ccline[1]{\hbox to\hsize{\vrule width\z@ height 21.2bp depth 10bp #1\hfil}}
\newcommand\committeeconclusion[1]{%
  \sdju@closerow
  \par
  \begingroup
  \normalfont\sdjufont{12bp}{19.5bp}%
  \setlength\sdju@cw{\sdju@formw-2\sdju@orule-\sdju@cclabelw-2\sdju@padx}%
  % 上部：建议
  \setbox\sdju@body\vbox{\sdju@bodysetup
    {\parindent=\z@ \noindent 建议：\par}#1\par}%
  \setlength\sdju@tmpa{203.9bp-\sdju@rule-2\sdju@pady}%
  \ifdim\dimexpr\ht\sdju@body+\dp\sdju@body\relax>\sdju@tmpa
    \setlength\sdju@tmpa{\ht\sdju@body+\dp\sdju@body}\fi
  % 下部：答辩结论
  \setbox\sdju@tail\vbox{\hsize=\sdju@cw \parindent=\z@ \offinterlineskip
    \kern 6bp
    \sdju@ccline{答辩结论：\hspace{1.5em}通过\sdju@checkbox{0}\hspace{5em}不通过\sdju@checkbox{0}}%
    \sdju@ccline{等第评定：\hspace{1.5em}优秀\sdju@checkbox{0}\hspace{1.5em}良好\sdju@checkbox{0}\hspace{1.5em}及格\sdju@checkbox{0}}%
    \sdju@ccline{答辩小组组长签名：}%
    \kern 15.6bp
    \sdju@ccline{答辩小组组员签名：}%
    \sdju@ccline{\hfill 年\hspace{2em}月\hspace{2em}日\hspace{3em}}%
    \vss}%
  \setlength\sdju@minh{\sdju@tmpa+207.8bp+2\sdju@pady}% 右格总高
  \sdju@getavail
  \ifdim\sdju@avail<\sdju@minh \newpage \sdju@thickrule \fi
  \nointerlineskip
  \moveright\sdju@formshift\vbox{%
    \hrule height\sdju@rule width\sdju@formw
    \hbox to\sdju@formw{%
      \vrule width\sdju@orule
      \vbox to\sdju@minh{\hsize=\dimexpr\sdju@cclabelw-\sdju@rule\relax
        \vss\sdjufont{10.5bp}{31.2bp}\offinterlineskip
        \hbox to\hsize{\hss 答辩\hss}\kern 20.7bp
        \hbox to\hsize{\hss 小组\hss}\kern 20.7bp
        \hbox to\hsize{\hss 结论\hss}\vss}%
      \vrule width\sdju@rule
      \vbox{\hsize=\dimexpr\sdju@cw+2\sdju@padx\relax
        \hbox{\hskip\sdju@padx\vbox to\dimexpr\sdju@tmpa+2\sdju@pady\relax{%
          \hsize=\sdju@cw\vskip\sdju@pady\box\sdju@body\vss}}%
        \hrule height\sdju@rule
        \hbox{\hskip\sdju@padx\vbox to\dimexpr207.8bp-\sdju@rule\relax{\hsize=\sdju@cw\box\sdju@tail}}}%
      \hfil\vrule width\sdju@orule}%
    \hrule height\sdju@rule width\sdju@formw}%
  \kern-\sdju@rule\prevdepth=\z@
  \sdju@thickrule
  \endgroup}

\RequirePackage[hidelinks,unicode]{hyperref}
\graphicspath{{figures/}}
\endinput
