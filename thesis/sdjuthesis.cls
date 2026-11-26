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
\RequirePackage{float}% 不浮动的图表：\begin{figure}[H] 就地排出（如章末的图不被推到「本章小结」之后）
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
\xeCJKDeclareCharClass{CJK}{"25A1,"221A,"2460->"2469}   % □ √ ①～⑩ 用中文字体

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
% 句末标点（. : ? !）之后与普通词距相同，不加大（\frenchspacing；Word 也不加大）。
%   放在 \AtBeginDocument 中，以免被宏包改回
\AtBeginDocument{\frenchspacing}
\hyphenpenalty=10000
\tolerance=1000
\setlength{\emergencystretch}{3em}
\urlstyle{same}
% 网址断行：可以在 / . - _ 等符号后断开（罚分 0），也可以在字母、数字后断开（罚分 300，只在符号处
%   排不好时才用，避免只能在符号处换行时整行网址排不满、字符间被拉开成「https : / / www . st . com」），
%   但网址开头的 8 个字符（「https://」「http://w」）之内不断开，不会出现「ht / tps://」。
%   正文中的 \url、手工录入的参考文献与 .bib 生成的参考文献（biblatex 的 \biburlsetup）都用这套规则：
%   每个字符排成 \mathchar 加 \Urlmuskip 的弹性间距，再按它在网址中的位置加罚分
\newcount\sdju@urlpos
\newcommand\sdju@urlprotect{8}% 网址开头不断开的字符数
\newcommand\sdju@urlletterpen{300}% 在字母、数字后断开的罚分
\newcommand\sdju@urlbreak[1]{\global\advance\sdju@urlpos\@ne
  \ifnum\sdju@urlpos>\sdju@urlprotect\relax\penalty#1\relax\fi}
\let\sdju@UrlSpecials\UrlSpecials
\newcommand\sdju@urlsetup{%
  \def\UrlBreaks{}\def\UrlBigBreaks{}%
  \def\UrlLeft{\global\sdju@urlpos\z@}%
  \let\UrlSpecials\sdju@UrlSpecials
  \def\do##1{\appto\UrlSpecials{\do##1{\mathchar`##1\mskip\Urlmuskip\sdju@urlbreak\sdju@urlletterpen}}}%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l\do\m
  \do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M
  \do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z
  \do\0\do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9
  \def\do##1{\appto\UrlSpecials{\do##1{\mathchar`##1\mskip\Urlmuskip\sdju@urlbreak\z@}}}%
  \do\.\do\/\do\-\do\_\do\&\do\:\do\?\do\=\do\#\do\@\do\!\do\;\do\,\do\+\do\|\do\]\do\)\do\>\do\*%
  \let\do\noexpand}
\sdju@urlsetup
\Urlmuskip=0mu plus 1mu
\setcounter{biburlnumpenalty}{0}% 字母、数字的断行改由 \sdju@urlsetup 处理
\setcounter{biburlucpenalty}{0}
\setcounter{biburllcpenalty}{0}
\appto\biburlsetup{\sdju@urlsetup}

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
% 浮动体的放置（与开题报告模板相同）：LaTeX 默认凡占半页以上的图表都可单独成页
%   （floatpagefraction = 0.5），浮动页从顶端排起后下半页整片空白。改为：图表可占页面上方 90%，
%   正文至少留 10%；只有占页面 80% 以上的图表（或几个合计）才单独成页
\renewcommand\topfraction{.9}
\renewcommand\bottomfraction{.6}
\renewcommand\textfraction{.1}
\renewcommand\floatpagefraction{.8}

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
\newcommand\sdju@coverdatedefault{二〇\hspace{1.5em}年\hspace{1.5em}月}
\newcommand\sdju@coverdatesrc{}
\newcommand\sdju@coverdate{\ifdefempty\sdju@coverdatesrc{\sdju@coverdatedefault}{\sdju@coverdatesrc}}
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
\newcommand\coverdate[1]{\renewcommand\sdju@coverdatesrc{#1}}% 留空：空白的「二〇 年 月」

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
%     题目过长时自动换行（各行长度均衡，见 \sdju@balance），下面的栏目随之下移
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
% 栏目行：#1 栏目名，#2 内容（写在下划线上）
%   填写内容的中心与最上面两行（学生姓名、学生学号）的内容中心在同一条竖线上（用户 2026-11-26
%   决定，与开题报告封面同一原则）：栏目名比「学生姓名：」长或短时（专业、校内指导教师、
%   企业指导教师、学院），下划线照旧从栏目名之后起到右端，内容按上面两行的中心排，
%   但不越出本行下划线的两端
\newcommand\sdju@coverfield[2]{%
  \setbox\z@\hbox{#1：}%
  \sdju@ulinew=\dimexpr\sdju@coverright-\sdju@coverleft-\wd\z@\relax
  \setbox\tw@\hbox{学生姓名：}%
  \ifdim\wd\z@=\wd\tw@
    \box\z@\rlap{\rule[-2.5bp]{\sdju@ulinew}{0.6bp}}%
    \hbox to\sdju@ulinew{\hss#2\hss}%
  \else
    \setbox\@tempboxa\hbox{#2}%
    % 内容左端距下划线左端：上面两行的内容中心 - 本行栏目名宽 - 内容宽的一半
    \dimen@=\dimexpr(\sdju@coverright-\sdju@coverleft+\wd\tw@)/2-\wd\z@-\wd\@tempboxa/2\relax
    \ifdim\dimen@>\dimexpr\sdju@ulinew-\wd\@tempboxa\relax \dimen@=\dimexpr\sdju@ulinew-\wd\@tempboxa\relax \fi
    \ifdim\dimen@<\z@ \dimen@=\z@ \fi
    \box\z@\rlap{\rule[-2.5bp]{\sdju@ulinew}{0.6bp}}%
    \hbox to\sdju@ulinew{\kern\dimen@\box\@tempboxa\hss}%
  \fi}
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
% 题目块：中文题目、英文题目各自居中，可自动换行；盒子深度 = 首行到末行基线的距离
\newcommand\sdju@covertitles{%
  \vtop{\hsize=170mm \parindent=\z@ \centering
    \dimen@=1.95\dimexpr\sdju@titlesize\relax
    \sdju@yahei\fontsize{\sdju@titlesize}{\the\dimen@}\selectfont
    \lineskiplimit=-\maxdimen
    {\sdju@balance{\sdju@title}\sdju@title\par}%
    \ifx\sdju@titleen\@empty\else{\sdju@balance{\sdju@titleen}\sdju@titleen\par}\fi
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
% 声明页的栏目（和封面一样，在导言区直接填写；留空时照样本留出空白）：
%   \confidentiality{保密|不保密}：版权使用授权书中勾选「保密」或「不保密」；保密时可选参数写解密年限，
%     如 \confidentiality[3]{保密}；留空则两项都不勾。旧写法 \confidential{<年数>}、\notconfidential 照旧可用
%   日期（各签字处「日期： 年 月 日」，{年}{月}{日}）：\integritydate 学术诚信声明；\aistudentdate、
%     \aisupervisordate AI 使用情况声明的作者、指导教师；\copyrightstudentdate、\copyrightsupervisordate
%     版权使用授权书的作者、指导教师；\declarationdate 一次填好上述各处（单独写的以单独写的为准）。
%     源码中没写的，用签名配置文件中的日期（作者 student、指导教师 supervisor）；都没有时留空待手写
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
\NewDocumentCommand\confidentiality{o m}{%
  \ifstrequal{#2}{保密}{\confidential{\IfNoValueTF{#1}{}{#1}}}{%
  \ifstrequal{#2}{不保密}{\notconfidential}{%
    \renewcommand\sdju@secretbox{\sdju@box}\renewcommand\sdju@publicbox{\sdju@box}%
    \renewcommand\sdju@secretyears{\hspace{2\ccwd}}%
    \ifblank{#2}{}{\ClassWarningNoLine{sdjuthesis}{\string\confidentiality\space 的参数应为「保密」或「不保密」}}}}}
\newcommand\declarationdate[3]{\sdju@setsrcdate{decl}{#1}{#2}{#3}}
\newcommand\integritydate[3]{\sdju@setsrcdate{decl-integrity}{#1}{#2}{#3}}
\newcommand\aistudentdate[3]{\sdju@setsrcdate{decl-ai-student}{#1}{#2}{#3}}
\newcommand\aisupervisordate[3]{\sdju@setsrcdate{decl-ai-supervisor}{#1}{#2}{#3}}
\newcommand\copyrightstudentdate[3]{\sdju@setsrcdate{decl-copyright-student}{#1}{#2}{#3}}
\newcommand\copyrightsupervisordate[3]{\sdju@setsrcdate{decl-copyright-supervisor}{#1}{#2}{#3}}
% 第 #2 处签字（integrity、ai-student…）的源码日期：单独写的 > \declarationdate；在本组内作为
%   角色 #1 的源码日期交给 \sdju@datefill（其中源码日期优先于签名配置）
\newcommand\sdju@declsrc[2]{%
  \ifcsname sdju@srcdate@decl-#2\endcsname
    \expandafter\let\csname sdju@srcdate@#1\expandafter\endcsname\csname sdju@srcdate@decl-#2\endcsname
  \else\ifcsname sdju@srcdate@decl\endcsname
    \expandafter\let\csname sdju@srcdate@#1\expandafter\endcsname\csname sdju@srcdate@decl\endcsname
  \fi\fi}
\newcommand\sdju@declindent{31.5bp}% 声明正文首行缩进
\newcommand\sdju@signone{189bp}%      学术诚信声明签名栏的左端
\newcommand\sdju@signright{286.9bp}%  两栏签名的右栏左端
% 日期：#1 签名人角色，#2 第几处签字；源码中写了日期时填入，否则签名配置文件给了该角色的日期时填入，
%   都没有时为空白（待手写）
\newcommand\sdju@date[2]{日期：\begingroup\sdju@declsrc{#1}{#2}%
  \sdju@datefill{#1}{2\ccwd}{1.5\ccwd}{1.5\ccwd}\endgroup}
% 签名处：#1 角色，#2 签名处的宽度。没有签名配置时留空（待手签）；有配置时由系统放入签名图片，
%   高 28 磅，紧接在「作者签名：」「指导教师签名：」之后，底部压在基线上（见文末「电子签名」）
\newcommand\sdju@signhere[2]{\sdju@signleft{#1}{#2}{28bp}}
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
   \noindent\hspace*{\sdju@signone}作者签名：\sdju@signhere{student}{\dimexpr\textwidth-\sdju@signone-5\ccwd\relax}\par
   \vspace{\baselineskip}
   \noindent\hspace*{\sdju@signone}\sdju@date{student}{integrity}\par
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
   \sdju@signpair{\sdju@declindent}%
     {作者签名：\sdju@signhere{student}{\dimexpr\sdju@signright-\sdju@declindent-5\ccwd-1\ccwd\relax}}%
     {指导教师签名：\sdju@signhere{supervisor}{\dimexpr\textwidth-\sdju@signright-7\ccwd\relax}}
   \vspace{\baselineskip}
   \sdju@signpair{\sdju@declindent}{\sdju@date{student}{ai-student}}{\sdju@date{supervisor}{ai-supervisor}}
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
   \sdju@signpair{\z@}%
     {作者签名：\sdju@signhere{student}{\dimexpr\sdju@signright-5\ccwd-1\ccwd\relax}}%
     {指导教师签名：\sdju@signhere{supervisor}{\dimexpr\textwidth-\sdju@signright-7\ccwd\relax}}
   \vspace{\baselineskip}
   \sdju@signpair{\z@}{\sdju@date{student}{copyright-student}}{\sdju@date{supervisor}{copyright-supervisor}}
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
% 英文摘要的词间距按 Word 的两端对齐方式排（真字体与 Fandol 回退版都启用，用户 2026-11-26 决定）：
%   Word 只拉宽、不压缩词间空格，行末空格留在行内（附件26 样本英文摘要各行右端都比版心右边短一个空格，
%   521.2 磅对 524.4 磅）。TeX 默认可压缩词间空格、行末不留空，每行多排几个字母，样本 23 行排成 22 行，
%   「Key words」比样本高 19.5 磅；按 Word 的方式排后与样本同为 23 行。
\newcommand\sdju@wordjustify{%
  \spaceskip=\fontdimen2\font plus \fontdimen3\font\relax
  \rightskip=\fontdimen2\font\relax}
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
%   只有一个附录时（用户 2026-11-26 决定），标题不编号，排成「附录」加一个全角空格加该附录的题目
%   （如「附录　程序清单」），目录中同样为「附录　程序清单」（\chapter 的可选参数为目录中的题目）；
%   引用它（\ref）得到「附录」；没有题目时排成「附　录」。图、表、公式仍编为 A-1、A-2…。
%   附录的个数在上一遍编译结束时记入 .aux（\sdju@appcount），本遍据此选择排法；
%   第一遍按多个附录排，latexmk 会自动重新编译。
\providecommand\sdju@appcount{0}
\newif\ifsdju@inappendix
\renewcommand\appendix{%
  \clearpage
  \global\sdju@inappendixtrue
  \setcounter{chapter}{0}\setcounter{section}{0}%
  \renewcommand\thechapter{\Alph{chapter}}%
  % 「附录A」中「录」与「A」之间不插入中西文间距（同「图2-1」「表2-1」）
  \ctexset{chapter/name={附录,},
    chapter/number=\texorpdfstring{\hbox{\thechapter}}{\thechapter},
    chapter/aftername=\enspace}%
  \ifnum\sdju@appcount=\@ne
    \let\sdju@origchapter\chapter \let\chapter\sdju@singleappendix \fi}
\NewDocumentCommand\sdju@singleappendix{s o m}{%
  \let\chapter\sdju@origchapter
  \ifblank{#3}
    {\sdjuchapter[附录]{附\hspace{1em}录}}
    {\sdjuchapter[附录\texorpdfstring{\hspace{1em}}{　}\IfValueTF{#2}{#2}{#3}]{附录\hspace{1em}#3}}%
  \refstepcounter{chapter}\def\@currentlabel{附录}% 「见\ref{…}」排为「见附录」
  \let\chapter\sdju@singleappendix}
\AtEndDocument{\ifsdju@inappendix
  \immediate\write\@auxout{\gdef\noexpand\sdju@appcount{\the\c@chapter}}\fi}

\RequirePackage[hidelinks,bookmarksnumbered,unicode]{hyperref}
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
      \ClassWarningNoLine{sdjuthesis}{配置文件声明了签名角色 #1，但找不到 \sdju@signdir#1.png，该处留空}#3}%
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
    \fi}%
  % 源码中写了日期（\studentdate、\supervisordate、\committeedate）时以源码为准
  \@for\sdju@r:=#1\do{%
    \ifcsname sdju@srcdate@\sdju@r\endcsname
      \expandafter\expandafter\expandafter\sdju@usesrcdate\csname sdju@srcdate@\sdju@r\endcsname
    \fi}}
\newcommand\sdju@usesrcdate[3]{\global\sdju@hasdatetrue\gdef\sdju@dy{#1}\gdef\sdju@dm{#2}\gdef\sdju@dd{#3}}
% 源码中的日期：\sdju@setsrcdate{角色}{年}{月}{日}；三项都留空时取消（为空白的「年 月 日」，或签名配置的日期）
\newcommand\sdju@setsrcdate[4]{\ifblank{#2#3#4}{\global\csundef{sdju@srcdate@#1}}
  {\global\@namedef{sdju@srcdate@#1}{{#2}{#3}{#4}}}}
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
