%% sdjulogbook.cls
%% 上海电机学院 毕业设计（论文）指导记录 LaTeX 模板
%% 依据：《教学归档材料及质量评价要素（2026 版）》附件32《毕业设计（论文）指导记录》
%%
%% 行距约定：Word 中文字体单倍行距 = 1.3 × 字号（小四号 15.6bp），文字在行框内上下居中。
%% 编译：xelatex（或直接 latexmk logbook.tex）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjulogbook}[2026/11/20 v1.0 SDJU Supervision Log Template]

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
% 字体：宋体 / 黑体 / Times New Roman，标题用方正大标宋；找不到时用 Fandol / TeX Gyre Termes
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
\def\sdju@grid{15.6bp}                       % 小四号单倍行距
% Word 中中文字体的单倍行距 = 1.3 × 字号；「x 倍行距」= x × 单倍行距。文字在行框内上下居中：
% 行框高 L、字号 s 时，基线在行框顶之下 (L - s)/2 + 0.86s（\sdju@ascent）。
\def\sdju@single{1.3}
% 指导记录的内容：小四号宋体 / Times New Roman，单倍行距，两端对齐（2026 版附件32 的记录格是空的，
%   按学校 Word 模板旧附件23《学生工作及教师指导记录本》记录格的段落格式）
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{15.6bp}%
  \abovedisplayskip 6bp plus 3bp minus 3bp
  \abovedisplayshortskip 0bp plus 3bp
  \belowdisplayshortskip 6bp plus 3bp minus 3bp
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
\setlength{\parindent}{0pt}% 不设首行缩进（样表没写明的按 Word 默认段落，不另加惯例）
\setlength{\parskip}{0pt}
% 页面顶端的第一行（标题、续页的表头）从版心顶算起，不加 \topskip
\setlength{\topskip}{0pt}
\AtBeginDocument{\setlength{\topskip}{0pt}}
% 当前字号、行距下 Word 行框中基线距行框顶的距离，及一个高为当前行距的行框支柱
\newcommand\sdju@ascent{\dimexpr(\baselineskip-1em)/2+0.86em\relax}
\newcommand\sdju@wstrut{\vrule height\sdju@ascent depth\dimexpr\baselineskip-\sdju@ascent\relax width\z@}
\newcommand\sdju@firstline{\prevdepth=\dimexpr\baselineskip-\sdju@ascent\relax}
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
\newcommand\sdju@listindent{0pt}
\setlist{nosep}
\setlist[enumerate,1]{label=（\arabic*）,leftmargin=0pt,labelindent=\sdju@listindent,
  itemindent=*,labelsep=0pt,align=left,listparindent=\sdju@listindent}
\setlist[itemize,1]{leftmargin=0pt,labelindent=\sdju@listindent,itemindent=*,
  labelsep=0.5em,listparindent=\sdju@listindent}
% 公式编号使用全角括号
\renewcommand\tagform@[1]{\maketag@@@{（\ignorespaces#1\unskip\@@italiccorr）}}

% ===============================================================
% 页面：A4；上、下 2.54cm，左、右 3.17cm（90 磅）；不印页眉页脚和页码（附件32 的表格本身没有页码）
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
\renewcommand\title[1]{\renewcommand\sdju@title{#1}}
\newcommand\school[1]{\renewcommand\sdju@school{#1}}
\newcommand\major[1]{\renewcommand\sdju@major{#1}}
\newcommand\classname[1]{\renewcommand\sdju@classname{#1}}
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\renewcommand\author[1]{\renewcommand\sdju@author{#1}}
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}
% 指导记录表至少排多少行（不足时补空行，附件32 为 15 行）：\recordrows{15}
\newcommand\sdju@recordrows{15}
\newcommand\recordrows[1]{\renewcommand\sdju@recordrows{#1}}

% ===============================================================
% 表格
%   表格外缘宽 467.2 磅，左外缘伸出版心左边 25.9 磅（竖线中线在 64.3、143.4、279.2、358.0、531.0 磅，
%   与附件32 一致，表格比版心宽）；线粗 0.5 磅。
%   行高（相邻横线间距）至少 31.7 磅，各单元格内容上下居中；单元格左右内边距 5.4 磅，上下 0。
%   \sdju@row{最小行高}{单元格…}：一行表格（不跨页），
%     \sdju@cell{宽度}{对齐 l/c/r/j}{内容}（宽度含其右侧竖线），最后一格用 \sdju@lastcell{对齐}{内容} 占满余下宽度。
% ===============================================================
\newlength\sdju@formw      \setlength\sdju@formw{467.2bp}%  表格总宽（外缘）
\newlength\sdju@formshift  \setlength\sdju@formshift{-25.94bp}% 表格左外缘相对版心左边的位移
\newlength\sdju@rule       \setlength\sdju@rule{0.5bp}%     框线
\newlength\sdju@orule      \setlength\sdju@orule{0.5bp}%    左右外框线
\newlength\sdju@padx       \setlength\sdju@padx{5.4bp}%     单元格左右内边距
\newlength\sdju@pady       \setlength\sdju@pady{0bp}%       单元格上下内边距
\newlength\sdju@rowh       \setlength\sdju@rowh{31.7bp}%    最小行高
\newlength\sdju@datew      \setlength\sdju@datew{79.1bp}%   第一列（栏目名、日期）宽
\newlength\sdju@used \newlength\sdju@axis \newlength\sdju@avail
\newbox\sdju@rowbox \newbox\sdju@notebox
\newcommand\sdju@align@l{\raggedright}
\newcommand\sdju@align@c{\centering}
\newcommand\sdju@align@r{\raggedleft}
\newcommand\sdju@align@j{}
\newcommand\sdju@cellbox[3]{%
  \hbox to\dimexpr#1-\sdju@rule\relax{\hskip\sdju@padx
    $\vcenter{\hsize=\dimexpr#1-\sdju@rule-2\sdju@padx\relax \linewidth=\hsize
      \parindent=\z@ \csname sdju@align@#2\endcsname
      \vskip\sdju@pady\sdju@wstrut#3\sdju@wstrut\par\vskip\sdju@pady}$%
    \hss}}
\newcommand\sdju@cell[3]{%
  \sdju@cellbox{#1}{#2}{#3}\vrule width\sdju@rule \addtolength\sdju@used{#1}}
\newcommand\sdju@lastcell[2]{%
  \sdju@cellbox{\dimexpr\sdju@formw-2\sdju@orule-\sdju@used+\sdju@rule\relax}{#1}{#2}}
% 排一行到 \sdju@rowbox
\newcommand\sdju@makerow[2]{%
  \setbox\sdju@rowbox\vbox{%
    \hrule height\sdju@rule width\sdju@formw
    \hbox to\sdju@formw{\setlength\sdju@used{\z@}\setbox\z@\hbox{$\vcenter{}$}\sdju@axis=\ht\z@
      \vrule width\sdju@orule
      \vrule width\z@ height\dimexpr(#1-\sdju@rule)/2+\sdju@axis\relax depth\dimexpr(#1-\sdju@rule)/2-\sdju@axis\relax
      #2\vrule width\sdju@orule}%
    \hrule height\sdju@rule width\sdju@formw}}
\newcommand\sdju@putrow{%
  \par\nointerlineskip
  \moveright\sdju@formshift\box\sdju@rowbox
  \kern-\sdju@rule\prevdepth=\z@}
\newcommand\sdju@row[2]{\sdju@makerow{#1}{#2}\sdju@putrow}
\newcommand\sdju@getavail{%
  \par\penalty\@M
  \ifdim\pagegoal=\maxdimen \setlength\sdju@avail{\vsize}%
  \else \setlength\sdju@avail{\pagegoal-\pagetotal}\fi}

% ===============================================================
% 标题与基本信息（附件32 上部）：\maketitle
%   「上海电机学院毕业设计（论文）指导记录」小二号方正大标宋（没有时用宋体加粗），居中，
%   基线在版心顶下 20.7 磅，表格上边线（外缘）再下 10.5 磅（2026 版附件32）
%   基本信息：学院、专业／班级、学号／姓名、指导教师（四格）；题目（两格）。四号宋体，单倍行距 18.2 磅，
%   栏目名加粗居中（2026 版为宋体加粗：填充＋描边），填写的内容不加粗、两端对齐（靠左）
% ===============================================================
\IfFontExistsTF{FZDaBiaoSong-B06S}
  {\setCJKfamilyfont{sdjudabiaosong}{FZDaBiaoSong-B06S}\newcommand\sdju@titlefont{\CJKfamily{sdjudabiaosong}}}
  {\newcommand\sdju@titlefont{\songti\bfseries}}
\newcommand\sdju@cellfont{\normalfont\sdjufont{14bp}{18.2bp}}% 表格栏目：四号，单倍行距
\newcommand\sdju@lab[1]{{\bfseries#1}}% 栏目名加粗
\newlength\sdju@titlebase \setlength\sdju@titlebase{20.7bp}% 标题基线在版心顶之下
\newlength\sdju@titlegap  \setlength\sdju@titlegap{10.5bp}%  标题基线到表格上边线（外缘）
\renewcommand\maketitle{%
  \par
  \setbox\z@\hbox to\hsize{\vrule height\sdju@titlebase depth\z@ width\z@
    \hfil\sdju@titlefont\sdjufont{18bp}{23.4bp}上海电机学院毕业设计（论文）指导记录\hfil}%
  \dp\z@=\z@ \box\z@
  \nointerlineskip\kern\sdju@titlegap
  \begingroup
  \sdju@cellfont
  \sdju@row{\sdju@rowh}{%
    \sdju@cell{\sdju@datew}{c}{\sdju@lab{学院}}\sdju@cell{135.8bp}{j}{\sdju@school}%
    \sdju@cell{78.8bp}{c}{\sdju@lab{专业}}\sdju@lastcell{j}{\sdju@major}}%
  \sdju@row{\sdju@rowh}{%
    \sdju@cell{\sdju@datew}{c}{\sdju@lab{班级}}\sdju@cell{135.8bp}{j}{\sdju@classname}%
    \sdju@cell{78.8bp}{c}{\sdju@lab{学号}}\sdju@lastcell{j}{\sdju@studentid}}%
  \sdju@row{\sdju@rowh}{%
    \sdju@cell{\sdju@datew}{c}{\sdju@lab{姓名}}\sdju@cell{135.8bp}{j}{\sdju@author}%
    \sdju@cell{78.8bp}{c}{\sdju@lab{指导教师}}\sdju@lastcell{j}{\sdju@supervisor}}%
  \sdju@row{\sdju@rowh}{%
    \sdju@cell{\sdju@datew}{c}{\sdju@lab{题目}}\sdju@lastcell{j}{\sdju@title}}%
  \endgroup}

% ===============================================================
% 正文栏目：\section{指导记录}
%   印出表头行「日期 | 指 导 记 录」，其后每条记录用 \record{日期}{记录内容} 写一行：
%   日期与记录内容均为两端对齐（靠左）、不缩进（样表没写明，按 Word 默认段落）；内容小四号宋体、单倍行距（15.6 磅）、两端对齐，行高随内容增加（至少 31.7 磅，
%   两行以内不加高）。一页排不下时下一页接着排，并重复表头行。记录不足 \recordrows 行（默认 15）时
%   在末尾补空行，空行只补到本页排满为止（连同其后的注）。
%   表格之后印附件32 的注：五号宋体加粗、单倍行距，紧接表格下边线（第一行基线在其下 11.6 磅），
%   左右与版心齐，排不下时转行。
% ===============================================================
\newif\ifsdju@recopen
\newcounter{sdjurecord}
\newcommand\sdju@headrow{%
  \begingroup\sdju@cellfont
  \sdju@row{\sdju@rowh}{%
    \sdju@cell{\sdju@datew}{c}{\sdju@lab{日期}}%
    \sdju@lastcell{c}{\sdju@lab{指\hspace{1em}导\hspace{1em}记\hspace{1em}录}}}%
  \endgroup}
\RenewDocumentCommand\section{s o m}{%
  \sdju@closerecords
  \global\sdju@recopentrue
  \setcounter{sdjurecord}{0}%
  \sdju@headrow}
% 一条记录：#1 日期，#2 内容
\newcommand\sdju@recordrow[2]{%
  \begingroup
  \normalfont\normalsize
  \sdju@makerow{\sdju@rowh}{%
    \sdju@cell{\sdju@datew}{j}{#1}\sdju@lastcell{j}{#2}}%
  \sdju@getavail
  \ifdim\dimexpr\ht\sdju@rowbox+\dp\sdju@rowbox\relax>\sdju@avail
    \newpage\sdju@headrow
  \fi
  \sdju@putrow
  \endgroup}
\newcommand\record[2]{%
  \ifsdju@recopen\else
    \ClassError{sdjulogbook}{\string\record\space 须写在 \string\section{指导记录} 之后}{}\fi
  \stepcounter{sdjurecord}%
  \sdju@recordrow{#1}{#2}}
\newcommand\sdju@closerecords{%
  \ifsdju@recopen
    \global\sdju@recopenfalse
    % 注
    \setbox\sdju@notebox\vbox{\hsize=\textwidth \linewidth=\hsize \parindent=\z@
      \normalfont\bfseries\sdjufont{10.5bp}{15.6bp}\sdju@firstline
      注：每周（次）填写一条，学生应重点记录师生间课题探讨、研究、解决及任务布置等信息。\par}%
    % 补空行：只补到本页排满为止，不为补空行而另起一页
    \begingroup\normalfont\normalsize
    \sdju@makerow{\sdju@rowh}{\sdju@cell{\sdju@datew}{c}{}\sdju@lastcell{j}{}}%
    \setlength\sdju@used{\ht\sdju@rowbox+\dp\sdju@rowbox-\sdju@rule
      +\ht\sdju@notebox+\dp\sdju@notebox}% 空行高度，另留出注的位置
    \sdju@getavail
    \loop
      \@tempswafalse
      \ifnum\value{sdjurecord}<\sdju@recordrows\relax
        \ifdim\sdju@avail>\sdju@used \@tempswatrue\fi
      \fi
    \if@tempswa
      \stepcounter{sdjurecord}%
      \sdju@makerow{\sdju@rowh}{\sdju@cell{\sdju@datew}{c}{}\sdju@lastcell{j}{}}%
      \sdju@putrow\sdju@getavail
    \repeat
    \endgroup
    \par\nointerlineskip\kern\sdju@rule
    \box\sdju@notebox
  \fi}
\AtEndDocument{\sdju@closerecords}

\RequirePackage[hidelinks,unicode]{hyperref}
\endinput
