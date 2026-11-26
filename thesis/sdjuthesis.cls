%% sdjuthesis.cls
%% 上海电机学院 学士学位论文 LaTeX 模板
%% 依据：《教学归档材料及质量评价要素（2026 版）》附件25《学士学位论文封面》、附件26《毕业设计（论文）格式规范》
%%       、学校《形式审核关键点内容（26 年 5 月及之后答辩的插入 AI 使用情况声明页）》
%%       （AI 使用情况声明页不在 2026 版样本中，按用户要求及形式审核要点保留，可用 noaideclaration 选项去掉）
%% 编译：xelatex -> biber -> xelatex -> xelatex（或直接 latexmk）
%%
%% 行距约定：Word 文档网格为 15.6 磅，「单倍行距」= 15.6bp，「1.25 倍」= 19.5bp，「2 倍」= 31.2bp。
%% 标题、目录等处的间距按 Word 的行框算法换算（见下文 \sdju@pre、\sdju@post 的说明）。
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjuthesis}[2026/11/20 v3.0 SDJU Bachelor Thesis Template]

% ---------------------------------------------------------------
% 选项：nodeclaration 不输出声明页；noaideclaration 不输出 AI 使用情况声明页
% ---------------------------------------------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=sdju,prefix=sdju@opt@}
\DeclareBoolOption{nodeclaration}
\DeclareBoolOption{noaideclaration}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*

\LoadClass[UTF8,a4paper,oneside,openany,zihao=-4,linespread=1,fontset=none]{ctexbook}

% ===============================================================
% 宏包
% ===============================================================
\RequirePackage{xparse}
\RequirePackage{calc}
\RequirePackage{etoolbox}
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{amsmath,amssymb}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{booktabs,longtable,multirow,array}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{tikz}
\RequirePackage[backend=biber,style=gb7714-2005,gbnamefmt=lowercase,
  gbpub=false,gbtype=true,url=true]{biblatex}

% ===============================================================
% 字体：宋体 / 黑体 / Times New Roman，封面用微软雅黑；找不到时用 Fandol / TeX Gyre Termes
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
  % 宋体、黑体等缺字（如「泰莱达因・艾斯科」的 U+30FB）时用 Fandol 中的同类字体补字，
  %   不再整字丢失（Word 也会换用其他字体显示）
  \xeCJKsetup{AutoFallBack=true}
  \setCJKmainfont{SimSun}[AutoFakeBold=\sdju@fakebold,AutoFakeSlant=.2,FallBack={FandolSong-Regular.otf}]
  \setCJKsansfont{SimHei}[AutoFakeBold=\sdju@fakebold,FallBack={FandolHei-Regular.otf}]
  \setCJKmonofont{SimSun}[FallBack={FandolSong-Regular.otf}]
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold=\sdju@fakebold,AutoFakeSlant=.2,FallBack={FandolSong-Regular.otf}]
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold=\sdju@fakebold,FallBack={FandolHei-Regular.otf}]
  \IfFontExistsTF{KaiTi}{\setCJKfamilyfont{zhkai}{KaiTi}[AutoFakeBold=\sdju@fakebold,FallBack={FandolKai-Regular.otf}]}{\setCJKfamilyfont{zhkai}{SimSun}[AutoFakeBold=\sdju@fakebold,FallBack={FandolSong-Regular.otf}]}
  \IfFontExistsTF{FangSong}{\setCJKfamilyfont{zhfs}{FangSong}[AutoFakeBold=\sdju@fakebold,FallBack={FandolFang-Regular.otf}]}{\setCJKfamilyfont{zhfs}{SimSun}[AutoFakeBold=\sdju@fakebold,FallBack={FandolSong-Regular.otf}]}
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
% 封面的「学士学位论文」和中英文题目：中西文都用微软雅黑（无则用黑体与无衬线西文字体）
\IfFontExistsTF{Microsoft YaHei}
  {\setCJKfamilyfont{sdjuyahei}{Microsoft YaHei}\newfontfamily\sdju@yaheilatin{Microsoft YaHei}%
   \newcommand\sdju@yahei{\CJKfamily{sdjuyahei}\sdju@yaheilatin}}
  {\newcommand\sdju@yahei{\heiti\sffamily}}
\xeCJKDeclareCharClass{CJK}{"25A1,"221A}   % □ √ 用中文字体

% ===============================================================
% 格式参数（字号单位 bp，即 Word 中的「磅」）
% ===============================================================
\newcommand\sdjufont[2]{\fontsize{#1}{#2}\selectfont}
\def\sdju@grid{15.6bp}                       % 单倍行距
% 正文：小四号，1.25 倍行距，首行缩进 2 字符
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

% ===============================================================
% Word 行框与 TeX 基线间距的换算
%   Word 把每一行排在一个「行框」里：行框高即行距（单倍 15.6 磅的倍数；四号、小二号字
%   高于一格，单倍行距时占两格 31.2 磅），文字在行框内上下居中；段前、段后加在行框之外，
%   相邻两段的段后与段前取较大者。TeX 则直接规定相邻两行基线的距离。
%   在字号或行距变化的地方（标题与正文之间、目录各级条目之间）两种算法结果不同，
%   下面的命令按 Word 的算法补上差值，使这些间距只由「字号、行框高、段前、段后」决定：
%     \sdju@above{字号}{行框高}  行框中基线以上的高度
%     \sdju@below{字号}{行框高}  行框中基线以下的高度
%     \sdju@pre{字号}{行框高}    从正文行（小四号、19.5 磅）转入这种行之前应补的距离
%     \sdju@post{字号}{行框高}   从这种行回到正文行之后应补的距离
% ===============================================================
\def\sdju@emcenter{0.359}% 宋体、黑体的字面中心在基线上方 0.359 个字高处
\def\sdju@above#1#2{\dimexpr(#2)/2+\sdju@emcenter\dimexpr#1\relax\relax}
\def\sdju@below#1#2{\dimexpr(#2)/2-\sdju@emcenter\dimexpr#1\relax\relax}
\def\sdju@pre#1#2{\dimexpr\sdju@below{12bp}{19.5bp}-\sdju@below{#1}{#2}\relax}
\def\sdju@post#1#2{\dimexpr\sdju@below{#1}{#2}-\sdju@below{12bp}{19.5bp}\relax}
% 标题紧跟在上一个标题之后时，LaTeX 不加段前距离；Word 取「上一标题的段后」与
% 「本标题的段前」中较大者。在各级标题的 format 开头调用，补上这段距离：
%   \sdju@headstart{字号}{行框高}{段前}{段后}
\newcommand\sdju@lastafter{0pt}
\newcommand\sdju@headstart[4]{%
  \if@nobreak
    \par\nobreak
    \@tempdima=\dimexpr#3-\sdju@lastafter\relax
    \ifdim\@tempdima<\z@ \@tempdima=\z@ \fi
    \vskip\dimexpr\@tempdima+\sdju@pre{#1}{#2}\relax
    \noindent
  \fi
  \gdef\sdju@lastafter{#4}}

% ===============================================================
% 断行：与 Word 一致，英文单词不用连字符拆开；排不下时放宽词距。
%   网址、长标识符可在 / . - _ 等符号处换行。
% ===============================================================
\hyphenpenalty=10000
\tolerance=1000
\setlength{\emergencystretch}{3em}
\urlstyle{same}
\g@addto@macro\UrlBreaks{\do\-\do\_\do\&}
% 长网址也可在字母、数字后换行（与 .bib 方式的 biburl*penalty 一致）。只能在符号处换行时，
%   整行网址排不满，多出的空白被摊到网址的每个字符之间，成了「https : / / www . st . com」
\@tfor\sdju@tmp:=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\do{%
  \expandafter\g@addto@macro\expandafter\UrlBreaks\expandafter{\expandafter\do\sdju@tmp}}
\Urlmuskip=0mu plus 1mu
\setcounter{biburlnumpenalty}{100}
\setcounter{biburlucpenalty}{100}
\setcounter{biburllcpenalty}{100}

% ===============================================================
% 图表题与表格
%   表名在表正上方，图名在图正下方，均为宋体小五号加粗；表格为三线表，线粗 0.5 磅。
%   表内文字默认小四号、单倍行距；列数多、排不下时可改小：\sdjutablesize{10.5bp}（五号），
%   写在表格之前，对其后的表格有效（放在花括号里则只对这一个表有效）。
%   跨页表格：在 longtable 的续页表头中用 \sdjucontinued{<列数>}，右上方显示「续表x-x」。
% ===============================================================
%   竖向位置按 Word 的行框换算（附件26 样本）：
%     表格每行占一个单倍行距的行框（15.6 磅），文字在行框中上下居中，表线（含表头下的线）
%     与行框之间不另留空，即表线中心到相邻一行基线 12.4 磅（上方）/ 3.7 磅（下方）；
%     表名的行框为 1.25 倍行距（19.5 磅），表名基线到表格上线 6.5 磅；
%     图名基线在图片下沿之下 13.1 磅（图片所在行的下沿 + 图名行框中的基线位置）。
\DeclareCaptionFont{sdjucap}{\songti\sdjufont{9bp}{\sdju@grid}\bfseries}
% 表名末行的深度固定为行框中基线以下的部分，表名到表格上线的距离不随字形变化
\DeclareCaptionTextFormat{sdjutable}{#1\vrule\@width\z@\@height\z@\@depth\sdju@below{9bp}{19.5bp}}
% 「表2-1」「图2-1」的「表」「图」与编号之间不留空（不插入中西文间距），编号后空半个字（样本 4.5 磅）
\DeclareCaptionLabelFormat{sdju}{#1\hbox{#2}}
\DeclareCaptionLabelSeparator{sdju}{\hspace{0.5em}}
\captionsetup{font=sdjucap,labelformat=sdju,labelsep=sdju,justification=centering,singlelinecheck=false}
\captionsetup[table]{position=top,skip=\z@,textformat=sdjutable}
% 图名首行的支柱高为 0.7 倍行距，图片下沿到图名基线 = skip + 0.7 × 15.6 磅 = 13.1 磅
\captionsetup[figure]{position=bottom,skip=2.18bp}
% 表内文字的支柱：行框高 = 行距，基线在行框中心下 0.359 个字高（与 Word 中宋体的位置一致）
\newcommand\sdju@tablestrut{%
  \setbox\strutbox\hbox{\vrule\@width\z@
    \@height\dimexpr\baselineskip/2+\sdju@emcenter\dimexpr\f@size pt\relax\relax
    \@depth\dimexpr\baselineskip/2-\sdju@emcenter\dimexpr\f@size pt\relax\relax}}
\newcommand\sdjutablefont{\sdjufont{12bp}{\sdju@grid}\sdju@tablestrut}
\newcommand\sdjutablesize[1]{\renewcommand\sdjutablefont{\sdjufont{#1}{\sdju@grid}\sdju@tablestrut}}
\newcommand\sdju@tablerules{%
  \renewcommand\arraystretch{1}%
  \setlength\aboverulesep{\z@}\setlength\belowrulesep{\z@}%
  \setlength\abovetopsep{\z@}\setlength\belowbottomsep{\z@}%
  \setlength\heavyrulewidth{0.5bp}\setlength\lightrulewidth{0.5bp}}
\newcommand\sdjutablesetup{\sdjutablefont\sdju@tablerules}
\AtBeginEnvironment{table}{\sdju@tablerules}
% longtable 之前先结束上一段，免得那一段被排成表内的单倍行距
\AtBeginEnvironment{longtable}{\par\sdjutablesetup}
% 浮动体开头 LaTeX 会恢复正文字号行距，这里再设回单倍行距（表格用表内字号）
\def\sdju@tablecaptype{table}
\appto\@floatboxreset{\lineskip\z@
  \ifx\@captype\sdju@tablecaptype \sdjutablefont \else \sdjufont{12bp}{\sdju@grid}\fi}
\newcommand\sdjucontinued[1]{%
  \multicolumn{#1}{@{}r@{}}{\sdjutablefont 续表\hbox{\thetable}}\\}% 右端与表格右边对齐
% 公式编号：全角括号，五号（附件26 样本的（2-1）为五号 Times New Roman，右对齐）
\renewcommand\tagform@[1]{\maketag@@@{\fontsize{10.5bp}{\sdju@grid}\selectfont
  （\ignorespaces#1\unskip\@@italiccorr）}}

% ===============================================================
% 程序代码：\begin{code} … \end{code}（附件26 和学校 Word 模板没有规定，以下是模板的约定）
%   五号、单倍行距，等宽字体（有 Courier New 用之，否则 TeX Gyre Cursor），汉字用宋体；
%   左端与版心左边对齐，原样保留空格缩进；过长的行自动折行，续行缩进 2 字符；
%   可跨页。可选参数传给 listings，如 \begin{code}[firstnumber=1,numbers=left]
% ===============================================================
\RequirePackage{listings}
\IfFontExistsTF{Courier New}
  {\newfontfamily\sdju@codefont{Courier New}[Ligatures={NoCommon,NoRequired}]}
  {\newfontfamily\sdju@codefont{texgyrecursor}[Extension=.otf,UprightFont=*-regular,
     BoldFont=*-bold,ItalicFont=*-italic,BoldItalicFont=*-bolditalic,
     Ligatures={NoCommon,NoRequired}]}% 代码中的 fl、fi 不连写
\lstdefinestyle{sdju}{%
  basicstyle=\sdjufont{10.5bp}{\sdju@grid}\sdju@codefont,
  columns=fullflexible,keepspaces=true,showstringspaces=false,
  breaklines=true,breakatwhitespace=false,breakindent=2em,
  postbreak={},prebreak={},
  xleftmargin=0pt,aboveskip=6bp,belowskip=6bp,
  tabsize=4,extendedchars=false,upquote=true,
  literate={-}{{-}}1 {*}{{*}}1}% 减号、星号照原样（listings 默认排成数学符号 − ∗）
\lstset{style=sdju}
\lstnewenvironment{code}[1][]{\lstset{style=sdju,#1}}{}

% ===============================================================
% 参考文献：GB/T 7714-2005 顺序编码制（与学校样本一致），\cite 为上标中括号；
%   条目悬挂缩进 2 字符。字号、行距与标题在后面「参考文献」一节设定。
% ===============================================================
\AtBeginBibliography{\renewcommand*{\bibpagespunct}{\addcolon}}% 页码前用冒号：1998:11-12
\AtBeginBibliography{\hyphenpenalty=10000 }% 文献样式会重设断词，这里改回不拆单词
\defbibenvironment{bibliography}
  {\list{}{%
     \setlength{\leftmargin}{2\ccwd}\setlength{\itemindent}{-2\ccwd}%
     \setlength{\labelwidth}{0pt}\setlength{\labelsep}{0pt}%
     \setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}}}
  {\endlist}
  {\item\printfield[labelnumberwidth]{labelnumber}\space}

% 手工录入的参考文献表（不用 .bib 文献库时）：条目自动编号 [1]、[2]…，格式同上。
%   \begin{sdju@reflist} \item 作者. 题名[J]. 刊名, 年, 卷(期): 页码. \end{sdju@reflist}
%   标题、字号、行距由 references 环境设定；正文中用 \sdjucite{1} 标注上标 [1]，
%   也可给条目加 \label{...}，再写 \sdjucite{\ref{...}}。
%   条目中「题名[J]」「手册[EB/OL]」的「[」与前面的汉字之间不留空（与 .bib 生成的条目、样本一致）：
%   xeCJK 默认在汉字与半角左括号「[」「(」之间加中西文间距，这里在列表内去掉这一处，
%   汉字与西文字母、数字之间的间距（如「基于 RFID」）不变
\ExplSyntaxOn
\cs_new_protected:Npn \sdju@nobracketglue
  {
    \cs_if_exist:NT \__xeCJK_boundary_capture_class:n
      {
        \xeCJK_inter_class_toks:nnn { CJK } { HalfLeft }
          { \xeCJK_class_group_end: \__xeCJK_boundary_capture_class:n { default } }
      }
  }
\ExplSyntaxOff
\newcounter{sdjuref}
\newenvironment{sdju@reflist}
  {\sdju@nobracketglue
   \list{[\arabic{sdjuref}]\space}{\usecounter{sdjuref}%
     \setlength{\leftmargin}{2\ccwd}\setlength{\itemindent}{-2\ccwd}%
     \setlength{\labelwidth}{0pt}\setlength{\labelsep}{0pt}%
     \setlength{\topsep}{0pt}\setlength{\partopsep}{0pt}%
     \setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}%
     \let\makelabel\@firstofone}%
   \hbadness=5000 }% 文献条目里不可拆的长串多，词距偏松时不必逐条警告（与 .bib 方式一致）
  {\endlist}
\newcommand\sdjucite[1]{\textsuperscript{[#1]}}

% 页面：上 2.8cm，下、左、右 2.5cm，页眉 2cm
% 页眉文字基线距纸边 65.8 磅，横线中心 69.7 磅（2026 版样本；页眉距纸边 2 cm，即页眉段落的行框顶在 2 cm 处）
\geometry{a4paper,top=28mm,bottom=25mm,left=25mm,right=25mm,
  headheight=12bp,headsep=8mm-12.6bp,footskip=10mm}
\raggedbottom
% 只放图表的页（浮动页）：图表从版心顶端排起（与 Word 中图片移到下一页时的位置一致），
%   不按 LaTeX 默认在页面中部上下居中（一张小图悬在空白页中间）
\setlength\@fptop{0pt}
\setlength\@fpsep{\floatsep}
\setlength\@fpbot{0pt plus 1fil}

% ===============================================================
% 论文信息
% ===============================================================
\newcommand\sdju@title{论文题目}
\newcommand\sdju@headtitle{\sdju@title}
\newcommand\sdju@author{}
\newcommand\sdju@studentid{}
\newcommand\sdju@school{}
\newcommand\sdju@major{}
\newcommand\sdju@supervisor{}
\newcommand\sdju@companysupervisor{}
\newcommand\sdju@titleen{}
\newcommand\sdju@coverdate{二〇\hspace{1.5em}年\hspace{1.5em}月}
\RenewDocumentCommand\title{om}{%
  \renewcommand\sdju@title{#2}%
  \IfNoValueTF{#1}
    {\renewcommand\sdju@headtitle{\begingroup\def\\{}#2\endgroup}}
    {\renewcommand\sdju@headtitle{#1}}}
\renewcommand\author[1]{\renewcommand\sdju@author{#1}}
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\newcommand\school[1]{\renewcommand\sdju@school{#1}}
\newcommand\major[1]{\renewcommand\sdju@major{#1}}
\newcommand\titleen[1]{\renewcommand\sdju@titleen{#1}}% 封面上的英文题目
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}% 校内指导教师
\newcommand\companysupervisor[1]{\renewcommand\sdju@companysupervisor{#1}}% 企业指导教师（无则不写，封面该栏留空）
\newcommand\coverdate[1]{\renewcommand\sdju@coverdate{#1}}

% ===============================================================
% 页眉：左为论文题目（黑体小五号），右为页码（小五号，左端距右边距 17 磅，与样本一致；
%       页码更宽时向右伸展、右端对齐右边距），下有 0.75 磅横线；页脚空
% 页码：封面无；声明、摘要、目录用 I, II…；正文起用 1, 2…
% ===============================================================
\newcommand\sdju@headpagew{17bp}
\newcommand\sdju@headpage{%
  \setbox\z@\hbox{\thepage}%
  \ifdim\wd\z@<\sdju@headpagew \hbox to\sdju@headpagew{\box\z@\hss}\else\box\z@\fi}
% 页眉题目超过「版心宽 - 页码栏 - 1 字」时在自己的一栏内转行（末行与页码同一基线），
%   不再与页码重叠；并给出警告，建议用 \title[页眉短题目]{…} 写一个短题目
\newcommand\sdju@headtitlew{\dimexpr\headwidth-\sdju@headpagew-1em\relax}
\newcommand\sdju@headtitlebox{%
  \setbox\z@\hbox{\sdju@headtitle}%
  \ifdim\wd\z@>\sdju@headtitlew
    \smash{\parbox[b]{\sdju@headtitlew}{\raggedright\sdju@headtitle}}% 向上伸展，不改页眉高度、版心位置
  \else\box\z@\fi}
\AtBeginDocument{%
  \setbox\z@\hbox{\sdjufont{9bp}{11.7bp}\heiti\sdju@headtitle}%
  \ifdim\wd\z@>\sdju@headtitlew
    \ClassWarningNoLine{sdjuthesis}{页眉中的论文题目一行排不下，已在页眉中转行；
      建议用 \string\title[页眉短题目]{封面题目} 给页眉写一个短题目}%
  \fi}
\fancypagestyle{sdju}{%
  \fancyhf{}%
  \fancyhead[L]{\sdjufont{9bp}{11.7bp}\heiti\sdju@headtitlebox}%
  \fancyhead[R]{\sdjufont{9bp}{11.7bp}\sdju@headpage}%
  \renewcommand\headrulewidth{0.75bp}%
  \renewcommand\footrulewidth{0pt}}
\fancypagestyle{plain}{\fancyhf{}\renewcommand\headrulewidth{0pt}}
\pagestyle{sdju}
\renewcommand\frontmatter{\clearpage\pagenumbering{Roman}\pagestyle{sdju}}
\renewcommand\mainmatter{\clearpage\pagenumbering{arabic}\pagestyle{sdju}}
\renewcommand\backmatter{\clearpage}

% ===============================================================
% 标题（字号、行框高、段前、段后四个参数；行框与间距的换算见前文）
%   一级：小二号黑体加粗，居中，行框 31.2 磅（两格），段前 0、段后 12 磅，每章另起页
%   二级：四号宋体，左对齐（首行缩进 2 字符），行框 31.2 磅（两格），段前 12、段后 0 磅
%   三级：小四号黑体，左对齐（首行缩进 2 字符），行框 15.6 磅（一格），段前 12、段后 0 磅
% ===============================================================
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{1}
% 一级标题开头：行框顶紧贴版心上沿加段前（不受上一页末行的影响），并记下段后 12 磅
\newcommand\sdju@chapstart{\par\nointerlineskip\noindent\gdef\sdju@lastafter{12bp}}
\newcommand\sdju@chapbefore{0bp}%  一级标题段前
\newcommand\sdju@chapafter{12bp}%  一级标题段后
\ctexset{
  chapter={
    format=\sdju@chapstart\centering\heiti\bfseries\sdjufont{18bp}{31.2bp}%
      \rule{0pt}{\sdju@above{18bp}{31.2bp}},
    nameformat={}, titleformat={},
    name={,}, number=\arabic{chapter}, aftername=\enspace,
    beforeskip=\dimexpr\sdju@chapbefore-\topskip\relax,
    afterskip=\dimexpr\sdju@chapafter+\sdju@post{18bp}{31.2bp}\relax,
    afterindent=true, pagestyle=sdju,
  },
  section={
    format=\sdju@headstart{14bp}{31.2bp}{12bp}{0bp}\raggedright\songti\sdjufont{14bp}{31.2bp},
    aftername=\enspace, indent=2em,
    beforeskip=\dimexpr 12bp+\sdju@pre{14bp}{31.2bp}\relax,
    afterskip=\dimexpr 0bp+\sdju@post{14bp}{31.2bp}\relax,
    afterindent=true,
  },
  subsection={
    format=\sdju@headstart{12bp}{15.6bp}{12bp}{0bp}\raggedright\heiti\sdjufont{12bp}{15.6bp},
    aftername=\enspace, indent=2em,
    beforeskip=\dimexpr 12bp+\sdju@pre{12bp}{15.6bp}\relax,
    afterskip=\dimexpr 0bp+\sdju@post{12bp}{15.6bp}\relax,
    afterindent=true,
  },
  bibname={参考文献},
  figurename={图},
  tablename={表},
}
% 不编号的一级标题；可选参数为目录中显示的文字（省略或留空则不进目录）
% 第二个可选参数为标题的段前距离（默认 0）
% （不能把 \chapter* 放进分组：标题之后「紧跟标题、不得分页」的状态要靠其后第一段解除，
%   分组会使这一机制失效，造成超过一页的目录无法分页）
\NewDocumentCommand\sdjuchapter{o O{0bp} m}{%
  \def\sdju@chapbefore{#2}%
  \chapter*{#3}%
  \def\sdju@chapbefore{0bp}%
  \IfValueT{#1}{\if\relax\detokenize{#1}\relax\else\addcontentsline{toc}{chapter}{#1}\fi}%
  \markboth{}{}}

% ===============================================================
% 目录：标题小二号黑体加粗居中，段前 31.2 磅、段后 12 磅；列出一、二级标题
%   一级：黑体四号，单倍行距（行框 31.2 磅）；二级：黑体小四号，单倍行距（行框 15.6 磅），左缩进 18 磅
%   （附件26 样本与 Word 模板均为 18 磅，即 1.5 个小四号字）
%   引导线为短横线；页码统一为五号 Times New Roman
% ===============================================================
\newcommand\sdju@tocpage[1]{{\sdjufont{10.5bp}{10.5bp}\rmfamily #1}}
\newcommand\sdju@tocdots{\leaders\hbox{\sdjufont{10.5bp}{10.5bp}\rmfamily -}\hfill}% 引导线：短横线
\contentsmargin{0pt}
\titlecontents{chapter}[0pt]
  {\vskip\sdju@pre{14bp}{31.2bp}\heiti\sdjufont{14bp}{31.2bp}}
  {\thecontentslabel\enspace}{}
  {\sdju@tocdots\sdju@tocpage{\thecontentspage}}
  [\vskip\sdju@post{14bp}{31.2bp}]
\titlecontents{section}[18bp]
  {\vskip\sdju@pre{12bp}{15.6bp}\heiti\sdjufont{12bp}{15.6bp}}
  {\thecontentslabel\enspace}{}
  {\sdju@tocdots\sdju@tocpage{\thecontentspage}}
  [\vskip\sdju@post{12bp}{15.6bp}]
\newcommand\sdjutableofcontents{%
  \sdjuchapter[][31.2bp]{目\hspace{1em}录}%
  % 各级条目行框高不同，行距一律按基线距离计算（不因上下两行挨得近而另加行间距）
  \begingroup\setlength\parindent{0pt}\lineskiplimit=-\maxdimen \@starttoc{toc}\endgroup
  \clearpage}

% ===============================================================
% 图、表、公式：按章编号（图2-1、表2-1、（2-1））；图表题与表格格式见前文
% ===============================================================
\renewcommand\thefigure{\thechapter-\arabic{figure}}
\renewcommand\thetable{\thechapter-\arabic{table}}
\renewcommand\theequation{\thechapter-\arabic{equation}}

% ===============================================================
% 列表
% ===============================================================
% 编号列表（各模板统一）：全角括号「（1）」「（2）」…，编号后紧接内容（全角括号自带半字空白），
%   首行与正文同样缩进 \sdju@listindent，转行回到左边。依据与取舍见 README「编号列表」
\newcommand\sdju@listindent{2em}
\setlist{nosep}
\setlist[enumerate,1]{label=（\arabic*）,leftmargin=0pt,labelindent=\sdju@listindent,
  itemindent=*,labelsep=0pt,align=left,listparindent=\sdju@listindent}
\setlist[itemize,1]{leftmargin=0pt,labelindent=\sdju@listindent,itemindent=*,
  labelsep=0.5em,listparindent=\sdju@listindent}

% ===============================================================
% 参考文献：GB/T 7714-2005 顺序编码制（与学校样本一致），\cite 为上标中括号
%   标题小二号黑体居中；条目小四号，悬挂缩进 2 字符，1.25 倍行距
% ===============================================================
\defbibheading{sdju}[\bibname]{\sdjuchapter[#1]{#1}}
\AtBeginBibliography{\sdjufont{12bp}{19.5bp}}
\newcommand\sdjubibliography{\printbibliography[heading=sdju]}
% 不用 .bib 文献库时，手工录入：\begin{references} \item 作者. 题名[J]. …… \end{references}
% 条目自动编号 [1]、[2]…；正文中用 \sdjucite{1} 标注
\newenvironment{references}
  {\sdjuchapter[\bibname]{\bibname}\sdjufont{12bp}{19.5bp}\begin{sdju@reflist}}
  {\end{sdju@reflist}}

% ===============================================================
% 封面（附件25）：各元素位置按《教学归档材料及质量评价要素（2026 版）》附件25 量取
%   校徽：宽 97.1mm，顶边距纸边 156 磅，居中
%   「学士学位论文」：40 磅微软雅黑居中，基线距纸边 329.7 磅
%   中文题目、英文题目：小一号（24 磅）微软雅黑居中，首行基线距纸边 385.7 磅，行距 46.8 磅（1.5 倍）；
%     题目过长时自动换行，下面的栏目随之下移
%   栏目：三号（16 磅）宋体，左端距纸边 116.6 磅，栏目名按实际宽度，下划线右端距纸边 452.7 磅；
%     自上而下为学生姓名、学生学号、专业、校内指导教师、企业指导教师、学院，行距 31.2 磅，
%     首行基线距纸边 514.6 磅（样本中题目末行基线之下 82.1 磅）
%   日期：三号宋体居中，在最后一个栏目下两行（62.4 磅）
%   题目超过样本的两行（中英文各一行）时，按下面的统一规则让整页仍在版心之内（上 2.8cm、下 2.5cm）：
%     (1) 多出的高度一半由题目及其以上部分（校徽、「学士学位论文」）上移、一半由栏目及日期下移；
%         上移以校徽顶边到版心上沿为限，下移以日期到版心下沿为限，一边到限后由另一边承担；
%     (2) 仍放不下时，按同一比例压缩两处弹性间距：题目末行到第一个栏目的距离 82.1 → 62.4 磅，
%         栏目行距 31.2 → 26 磅（日期仍在最后一个栏目下两行）；
%     (3) 压缩到下限仍放不下时，题目字号逐级缩小（24、22、20、18、16 磅，行距保持 1.95 倍字号），
%         并给出警告，提示缩短题目。
% ===============================================================
\definecolor{sdjucover}{HTML}{231815}
\newcommand\sdju@coverleft{116.6bp}%    栏目左端
\newcommand\sdju@coverright{452.7bp}%   下划线右端
\newcommand\sdju@coverpitch{31.2bp}%    栏目行距
\newcommand\sdju@coverpitchmin{26bp}%   栏目行距的下限（题目过长时压缩）
\newcommand\sdju@titlesize{24bp}%       题目字号（小一号）
\newcommand\sdju@titletop{385.7bp}%     题目首行基线
\newcommand\sdju@titlespan{46.8bp}%     样本中题目首行到末行基线的距离（中英文各一行）
\newcommand\sdju@fieldtop{514.6bp}%     第一个栏目的基线（题目不长时）
\newcommand\sdju@fieldgap{82.1bp}%      题目末行基线到第一个栏目基线的距离
\newcommand\sdju@fieldgapmin{62.4bp}%   上项的下限（题目过长时压缩）
\newcommand\sdju@logotop{156bp}%        校徽顶边
\newcommand\sdju@datebase{733bp}%       日期基线（题目不长时）= 514.6 + 7 × 31.2
\newdimen\sdju@fieldy
\newdimen\sdju@covershift
\newdimen\sdju@coverdown
\newdimen\sdju@coverextra
\newdimen\sdju@coverupmax
\newdimen\sdju@coverdownmax
\newdimen\sdju@coversqueeze
\newdimen\sdju@coverrest
\newdimen\sdju@coverpitchlen
\newdimen\sdju@fieldgaplen
\newlength\sdju@ulinew
\newbox\sdju@titlebox
% 栏目行：#1 栏目名，#2 内容（写在下划线上，居中）
\newcommand\sdju@coverfield[2]{%
  \setbox\z@\hbox{#1：}%
  \sdju@ulinew=\dimexpr\sdju@coverright-\sdju@coverleft-\wd\z@\relax
  \box\z@\rlap{\rule[-2.5bp]{\sdju@ulinew}{0.6bp}}%
  \hbox to\sdju@ulinew{\hss#2\hss}}
% 题目块：中文题目、英文题目各自居中，可自动换行；盒子深度 = 首行到末行基线的距离
\newcommand\sdju@covertitles{%
  \vtop{\hsize=170mm \parindent=\z@ \centering
    \dimen@=1.95\dimexpr\sdju@titlesize\relax
    \sdju@yahei\fontsize{\sdju@titlesize}{\the\dimen@}\selectfont
    \lineskiplimit=-\maxdimen
    \sdju@title\par
    \ifx\sdju@titleen\@empty\else\sdju@titleen\par\fi
    % 题目为空时盒中没有行，\prevdepth 为 -1000pt，不能拿来回退（否则盒子深 1000pt）
    \ifdim\prevdepth>\z@ \kern-\prevdepth\fi}}
% 封面能容纳的额外高度：上移 + 下移 + 两处弹性间距的压缩量
\newcommand\sdju@coverroom{%
  \dimexpr\sdju@coverupmax+\sdju@coverdownmax+\sdju@coversqueeze\relax}
\newcommand\makecover{%
  \begin{titlepage}
  \thispagestyle{empty}%
  % 上移、下移的限度（版心上沿 = 1in + \topmargin + \headheight + \headsep）
  \sdju@coverupmax=\dimexpr\sdju@logotop-(1in+\voffset+\topmargin+\headheight+\headsep)\relax
  \setbox\z@\hbox{\songti\fontsize{16bp}{20.8bp}\selectfont\strut\sdju@coverdate}% 日期行框的下沿
  \sdju@coverdownmax=\dimexpr 1in+\voffset+\topmargin+\headheight+\headsep+\textheight
    -\sdju@datebase-\dp\z@\relax
  \ifdim\sdju@coverupmax<\z@ \sdju@coverupmax=\z@ \fi
  \ifdim\sdju@coverdownmax<\z@ \sdju@coverdownmax=\z@ \fi
  \sdju@coversqueeze=\dimexpr\sdju@fieldgap-\sdju@fieldgapmin
    +7\dimexpr\sdju@coverpitch-\sdju@coverpitchmin\relax\relax
  % 从小一号起逐级缩小题目字号，直到放得下
  \@tfor\sdju@tmp:={24bp}{22bp}{20bp}{18bp}{16bp}\do{%
    \edef\sdju@titlesize{\sdju@tmp}%
    \setbox\sdju@titlebox\hbox{\sdju@covertitles}%
    \sdju@coverextra=\dimexpr\dp\sdju@titlebox-\sdju@titlespan\relax
    \ifdim\sdju@coverextra<\z@ \sdju@coverextra=\z@ \fi
    \ifdim\sdju@coverextra>\sdju@coverroom\else\@break@tfor\fi}%
  \ifdim\sdju@coverextra>\sdju@coverroom
    \ClassWarningNoLine{sdjuthesis}{封面题目过长：题目缩小到 \sdju@titlesize\space 仍超出版心，请缩短中文或英文题目}%
  \else\ifdim\sdju@titlesize<24bp
    \ClassWarningNoLine{sdjuthesis}{封面题目过长：小一号（24bp）排不下，题目字号已缩小为 \sdju@titlesize；建议缩短题目}%
  \fi\fi
  % (1) 上下各分一半，一边到限后由另一边承担
  \sdju@coverdown=\dimexpr\sdju@coverextra/2\relax
  \ifdim\sdju@coverdown>\sdju@coverdownmax \sdju@coverdown=\sdju@coverdownmax \fi
  \sdju@covershift=\dimexpr\sdju@coverextra-\sdju@coverdown\relax
  \ifdim\sdju@covershift>\sdju@coverupmax \sdju@covershift=\sdju@coverupmax \fi
  \sdju@coverdown=\dimexpr\sdju@coverextra-\sdju@covershift\relax
  \ifdim\sdju@coverdown>\sdju@coverdownmax \sdju@coverdown=\sdju@coverdownmax \fi
  % (2) 余下的高度按同一比例压缩两处弹性间距
  \sdju@coverrest=\dimexpr\sdju@coverextra-\sdju@covershift-\sdju@coverdown\relax
  \ifdim\sdju@coverrest>\sdju@coversqueeze \sdju@coverrest=\sdju@coversqueeze \fi
  \ifdim\sdju@coverrest>\z@
    \ClassInfo{sdjuthesis}{封面题目较长，已压缩题目与栏目之间的间距和栏目行距}%
    \sdju@fieldgaplen=\dimexpr\sdju@fieldgap-(\sdju@fieldgap-\sdju@fieldgapmin)
      *\sdju@coverrest/\sdju@coversqueeze\relax
    \sdju@coverpitchlen=\dimexpr\sdju@coverpitch-(\sdju@coverpitch-\sdju@coverpitchmin)
      *\sdju@coverrest/\sdju@coversqueeze\relax
  \else
    \sdju@fieldgaplen=\sdju@fieldgap\relax
    \sdju@coverpitchlen=\sdju@coverpitch\relax
  \fi
  \sdju@fieldy=\dimexpr\sdju@titletop-\sdju@covershift+\dp\sdju@titlebox+\sdju@fieldgaplen\relax
  \begin{tikzpicture}[remember picture,overlay]
    \coordinate (T) at ([yshift=\sdju@covershift]current page.north);% 题目及其以上部分
    \coordinate (F) at (current page.north);
    \coordinate (L) at (current page.north west);
    \node[anchor=north,inner sep=0pt] at ([yshift=-\sdju@logotop]T)
      {\includegraphics[width=97.1mm]{sdju-logo}};
    \node[anchor=base,inner sep=0pt] at ([yshift=-329.7bp]T)
      {\sdju@yahei\fontsize{40bp}{52bp}\selectfont 学士学位论文};
    \node[anchor=base,inner sep=0pt] at ([yshift=-\sdju@titletop]T) {\box\sdju@titlebox};
    \begin{scope}[every node/.style={anchor=base west,inner sep=0pt,
        font=\songti\fontsize{16bp}{20.8bp}\selectfont\color{sdjucover}}]
      \node at ([xshift=\sdju@coverleft,yshift=-\sdju@fieldy]L)
        {\sdju@coverfield{学生姓名}{\sdju@author}};
      \node at ([xshift=\sdju@coverleft,yshift=-\sdju@fieldy-\sdju@coverpitchlen]L)
        {\sdju@coverfield{学生学号}{\sdju@studentid}};
      \node at ([xshift=\sdju@coverleft,yshift=-\sdju@fieldy-2\sdju@coverpitchlen]L)
        {\sdju@coverfield{专业}{\sdju@major}};
      \node at ([xshift=\sdju@coverleft,yshift=-\sdju@fieldy-3\sdju@coverpitchlen]L)
        {\sdju@coverfield{校内指导教师}{\sdju@supervisor}};
      \node at ([xshift=\sdju@coverleft,yshift=-\sdju@fieldy-4\sdju@coverpitchlen]L)
        {\sdju@coverfield{企业指导教师}{\sdju@companysupervisor}};
      \node at ([xshift=\sdju@coverleft,yshift=-\sdju@fieldy-5\sdju@coverpitchlen]L)
        {\sdju@coverfield{学院}{\sdju@school}};
      \node[anchor=base] at ([yshift=-\sdju@fieldy-7\sdju@coverpitchlen]F) {\sdju@coverdate};
    \end{scope}
  \end{tikzpicture}
  \end{titlepage}}

% ===============================================================
% 声明页（学术诚信声明、AI 使用情况声明、版权使用授权书）
%   附件26（2026 版）只有学术诚信声明和版权使用授权书两页，标题高度一致；
%   AI 使用情况声明按用户要求保留在两者之间（选项 noaideclaration 可去掉）
%   全页按 2 倍行距（31.2 磅）排：空两行；标题两行（上海电机学院 / 声明名称），小二号黑体加粗居中；
%   空一行；正文四号宋体，首行缩进 31.5 磅（附件26 样本与 Word 模板）；签名前空三行（AI 声明内容多，空一行）；
%   签名与日期间空一行。签名、日期的位置（相对版心左边）：学术诚信声明一栏，在 189 磅处；
%   AI 使用情况声明、版权使用授权书两栏，左栏分别在首行缩进处、版心左边，右栏在 286.9 磅处；
%   日期为「日期：」+ 2 字 +「年」+ 1.5 字 +「月」+ 1.5 字 +「日」（四号字宽）
% ===============================================================
\newcommand\sdju@decltitle[1]{%
  \def\sdju@chapbefore{62.4bp}%
  \def\sdju@chapafter{31.2bp+\sdju@pre{14bp}{31.2bp}}%
  \chapter*{上海电机学院\\#1}%
  \def\sdju@chapbefore{0bp}\def\sdju@chapafter{12bp}}
\newenvironment{sdju@declbody}
  {\par\sdjufont{14bp}{31.2bp}\setlength\parindent{\sdju@declindent}}
  {\par}
% 签名、日期行
% 版权使用授权书的「保密」「不保密」：默认两项都空着，打印后手工勾选；
%   也可在导言区写 \confidential{<年数>}（保密，并填上解密年限）或 \notconfidential（不保密）
\newcommand\sdju@box{□}
\newcommand\sdju@checkedbox{\makebox[1em]{\rlap{□}\hbox to 1em{\hss √\hss}}}
\newcommand\sdju@secretbox{\sdju@box}
\newcommand\sdju@publicbox{\sdju@box}
\newcommand\sdju@secretyears{\hspace{2\ccwd}}
\newcommand\confidential[1]{%
  \renewcommand\sdju@secretbox{\sdju@checkedbox}\renewcommand\sdju@publicbox{\sdju@box}%
  \renewcommand\sdju@secretyears{\makebox[2\ccwd]{#1}}}
\newcommand\notconfidential{%
  \renewcommand\sdju@secretbox{\sdju@box}\renewcommand\sdju@publicbox{\sdju@checkedbox}%
  \renewcommand\sdju@secretyears{\hspace{2\ccwd}}}
\newcommand\sdju@declindent{31.5bp}% 声明正文首行缩进
\newcommand\sdju@signone{189bp}%      学术诚信声明签名栏的左端
\newcommand\sdju@signright{286.9bp}%  两栏签名的右栏左端
\newcommand\sdju@date{日期：\hspace{2\ccwd}年\hspace{1.5\ccwd}月\hspace{1.5\ccwd}日}
% \sdju@signpair{左栏左端}{左栏}{右栏}
\newcommand\sdju@signpair[3]{\noindent\hspace*{#1}%
  \makebox[\dimexpr\sdju@signright-(#1)\relax][l]{#2}#3\par}
\newcommand\makedeclaration{%
  \ifsdju@opt@nodeclaration\else
  % ---- 学术诚信声明 ----
  \sdju@decltitle{毕业设计（论文）学术诚信声明}%
  \begin{sdju@declbody}
   本人郑重声明：所呈交的毕业设计（论文），是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律结果由本人承担。\par
   \vspace{3\baselineskip}
   \noindent\hspace*{\sdju@signone}作者签名：\par
   \vspace{\baselineskip}
   \noindent\hspace*{\sdju@signone}\sdju@date\par
  \end{sdju@declbody}
  % ---- AI 使用情况声明（2026 版样本中没有这一页，按用户要求保留）----
  \ifsdju@opt@noaideclaration\else
  \sdju@decltitle{毕业设计（论文）AI使用情况声明}%
  \begin{sdju@declbody}
   如果在撰写毕业设计（论文）的过程中，辅助使用了AI工具。本人将做好原始材料与数据的保留工作。本人承诺如下：\par
   1．未使用AI工具直接完成本科毕业设计（论文）的研究核心。如：方案设计、模型设计、技术开发、算法验证、实验步骤、实验分析、结果调研、结论分析等涉及创新性的内容。\par
   2．未使用AI工具生成或篡改原始数据、原始图片图像等。\par
   3．未直接使用AI工具生成论文结构框架、章节段落、结论总结等内容。\par
   4．未将涉及保密以及暂不宜公开的内容时，上传至AI平台。\par
   5．未引用AI生成的未经标注版权的内容。\par
   本人承诺所提交论文的原创性，完全符合《上海电机学院本科毕业设计（论文）过程管理实施细则》及《上海电机学院本科毕业设计（论文）使用AI工具的指导性意见》及相关学术诚信要求。\par
   \vspace{\baselineskip}
   \sdju@signpair{\sdju@declindent}{作者签名：}{指导教师签名：}
   \vspace{\baselineskip}
   \sdju@signpair{\sdju@declindent}{\sdju@date}{\sdju@date}
  \end{sdju@declbody}
  \fi
  % ---- 版权使用授权书 ----
  \sdju@decltitle{毕业设计（论文）版权使用授权书}%
  \begin{sdju@declbody}
   本毕业设计（论文）作者同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权上海电机学院可以将本毕业设计（论文）的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本毕业设计（论文）。\par
   \hphantom{本论文属于}\hspace{2\ccwd}\textbf{保密}\sdju@secretbox，在\underline{\sdju@secretyears}年解密后适用本授权书。\par
   本论文属于\par
   \hphantom{本论文属于}\hspace{2\ccwd}\textbf{不保密}\sdju@publicbox。\par
   （请在以上方框内打“√”）\par
   \vspace{3\baselineskip}
   \sdju@signpair{\z@}{作者签名：}{指导教师签名：}
   \vspace{\baselineskip}
   \sdju@signpair{\z@}{\sdju@date}{\sdju@date}
  \end{sdju@declbody}
  \clearpage
  \fi}

% ===============================================================
% 摘要
%   中文：标题小二号黑体居中；正文小四号宋体，首行缩进 2 字符，段前段后 12 磅，1.25 倍行距
%         （标题的段后 12 磅与首段的段前 12 磅取较大者，不叠加）；
%         「关键词：」五号黑体，关键词小四号宋体，逗号分开，最后一个后面无标点；
%         关键词行为单倍行距（行框 15.6 磅），段前 12 磅（附件26 样本与 Word 模板）
%   英文：标题小二号 Times New Roman 加粗居中，段前 31.2 磅；正文同上；「Key words:」五号加粗；
%         关键词行为 1.5 倍行距（行框 23.4 磅），段前 12 磅（附件26 样本与 Word 模板）
%   两种行距照样本原样保留（用户 2026-11-26 决定）；关键词行的位置按行框算法换算：
%   与摘要末行基线相距 中文 29.5 磅、英文 33.5 磅
% ===============================================================
\newcommand\sdju@keywords{}
\newcommand\sdju@keywordsen{}
\newcommand\keywords[1]{\renewcommand\sdju@keywords{#1}}
\newcommand\keywordsen[1]{\renewcommand\sdju@keywordsen{#1}}
% \sdju@kwline{行框高}{标签}{关键词}：小四号，行距为行框高；悬挂缩进到标签之后
\newcommand\sdju@kwline[3]{%
  \par\vskip\sdju@pre{12bp}{#1}%
  \begingroup\sdjufont{12bp}{#1}%
  \noindent\settowidth{\@tempdima}{#2}%
  \hangindent=\@tempdima\hangafter=1
  #2#3\par\endgroup}
\newenvironment{abstract}
  {\sdjuchapter{摘\hspace{1em}要}\setlength{\parskip}{12bp}\vspace{-\parskip}}
  {\sdju@kwline{15.6bp}{{\heiti\sdjufont{10.5bp}{15.6bp}关键词：}}{\sdju@keywords}%
   \setlength{\parskip}{0pt}}
% 英文摘要的词间距按 Word 的两端对齐方式排（只在有 Times New Roman 等真字体时启用）：Word 只拉宽、
%   不压缩词间空格，行末空格留在行内（附件26 样本英文摘要各行右端都比版心右边短一个空格，
%   521.2 磅对 524.4 磅）。TeX 默认可压缩词间空格、行末不留空，每行多排几个字母，样本 23 行排成 22 行，
%   「Key words」比样本高 19.5 磅；按 Word 的方式排后与样本同为 23 行。
\newcommand\sdju@wordjustify{%
  \ifsdju@realfonts
    \spaceskip=\fontdimen2\font plus \fontdimen3\font\relax
    \rightskip=\fontdimen2\font\relax
  \fi}
\newenvironment{abstracten}
  {\sdjuchapter[][31.2bp]{\rmfamily\bfseries ABSTRACT}\setlength{\parskip}{12bp}\vspace{-\parskip}%
   \sdju@wordjustify}
  {\sdju@kwline{23.4bp}{{\rmfamily\bfseries\sdjufont{10.5bp}{23.4bp}Key words: }}{\sdju@keywordsen}%
   \setlength{\parskip}{0pt}}

% ===============================================================
% 致谢：标题小二号黑体居中；正文五号宋体，首行缩进 2 字符，单倍行距
% ===============================================================
\newenvironment{acknowledgements}
  {\sdjuchapter[致谢]{致\hspace{1em}谢}\vspace{\sdju@pre{10.5bp}{15.6bp}}\sdjufont{10.5bp}{\sdju@grid}}
  {\par}

% ===============================================================
% 附录（可选，放在致谢之后）：\appendix 之后的 \chapter 编为「附录A」「附录B」…，
%   标题格式与一级标题相同，进入目录；附录中的图、表、公式编为 A-1、A-2…
% ===============================================================
\renewcommand\appendix{%
  \clearpage
  \setcounter{chapter}{0}\setcounter{section}{0}%
  \renewcommand\thechapter{\Alph{chapter}}%
  % 「附录A」中「录」与「A」之间不插入中西文间距（同「图2-1」「表2-1」）
  \ctexset{chapter/name={附录,},
    chapter/number=\texorpdfstring{\hbox{\thechapter}}{\thechapter},
    chapter/aftername=\enspace}}

\RequirePackage[hidelinks,bookmarksnumbered,unicode]{hyperref}
\graphicspath{{figures/}}
\endinput
