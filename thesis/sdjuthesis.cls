%% sdjuthesis.cls
%% 上海电机学院 学士学位论文 LaTeX 模板
%% 依据：附件15《学士学位论文封面》、附件17《毕业设计（论文）格式规范》、《论文格式-无红色标注.pdf》
%% 编译：xelatex -> biber -> xelatex -> xelatex（或直接 latexmk）
%%
%% 行距约定：Word 文档网格为 15.6 磅，「单倍行距」= 15.6bp，「1.25 倍」= 19.5bp，「2 倍」= 31.2bp。
%% 标题、目录等处的间距按 Word 的行框算法换算（见下文 \sdju@pre、\sdju@post 的说明）。
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjuthesis}[2026/11/09 v2.3 SDJU Bachelor Thesis Template]

% ---------------------------------------------------------------
% 选项：nodeclaration 不输出声明页
% ---------------------------------------------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=sdju,prefix=sdju@opt@}
\DeclareBoolOption{nodeclaration}
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
\IfFontExistsTF{Microsoft YaHei}
  {\setCJKfamilyfont{sdjuyahei}{Microsoft YaHei}\newcommand\sdju@yahei{\CJKfamily{sdjuyahei}}}
  {\newcommand\sdju@yahei{\heiti}}
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
\DeclareCaptionFont{sdjucap}{\songti\sdjufont{9bp}{\sdju@grid}\bfseries}
\captionsetup{font=sdjucap,labelsep=space,justification=centering,singlelinecheck=false}
\captionsetup[table]{position=top,skip=4bp}
\captionsetup[figure]{position=bottom,skip=6bp}
\newcommand\sdjutablefont{\sdjufont{12bp}{\sdju@grid}}
\newcommand\sdjutablesize[1]{\renewcommand\sdjutablefont{\sdjufont{#1}{\sdju@grid}}}
\newcommand\sdju@tablerules{%
  \renewcommand\arraystretch{1}%
  \setlength\heavyrulewidth{0.5bp}\setlength\lightrulewidth{0.5bp}}
\newcommand\sdjutablesetup{\sdjutablefont\sdju@tablerules}
\AtBeginEnvironment{table}{\sdju@tablerules}
% longtable 之前先结束上一段，免得那一段被排成表内的单倍行距
\AtBeginEnvironment{longtable}{\par\sdjutablesetup}
% 浮动体开头 LaTeX 会恢复正文字号行距，这里再设回单倍行距（表格用表内字号）
\def\sdju@tablecaptype{table}
\appto\@floatboxreset{%
  \ifx\@captype\sdju@tablecaptype \sdjutablefont \else \sdjufont{12bp}{\sdju@grid}\fi}
\newcommand\sdjucontinued[1]{%
  \multicolumn{#1}{r}{\sdjutablefont 续表\thetable}\\}
% 公式编号使用全角括号
\renewcommand\tagform@[1]{\maketag@@@{（\ignorespaces#1\unskip\@@italiccorr）}}

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
\newcounter{sdjuref}
\newenvironment{sdju@reflist}
  {\list{[\arabic{sdjuref}]\space}{\usecounter{sdjuref}%
     \setlength{\leftmargin}{2\ccwd}\setlength{\itemindent}{-2\ccwd}%
     \setlength{\labelwidth}{0pt}\setlength{\labelsep}{0pt}%
     \setlength{\topsep}{0pt}\setlength{\partopsep}{0pt}%
     \setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}%
     \let\makelabel\@firstofone}%
   \hbadness=5000 }% 文献条目里不可拆的长串多，词距偏松时不必逐条警告（与 .bib 方式一致）
  {\endlist}
\newcommand\sdjucite[1]{\textsuperscript{[#1]}}

% 页面：上 2.8cm，下、左、右 2.5cm，页眉 2cm
\geometry{a4paper,top=28mm,bottom=25mm,left=25mm,right=25mm,
  headheight=12bp,headsep=8mm-12bp,footskip=10mm}
\raggedbottom

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
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}
\newcommand\coverdate[1]{\renewcommand\sdju@coverdate{#1}}

% ===============================================================
% 页眉：左为论文题目（黑体小五号），右为页码（小五号），下有 0.75 磅横线；页脚空
% 页码：封面无；声明、摘要、目录用 I, II…；正文起用 1, 2…
% ===============================================================
\fancypagestyle{sdju}{%
  \fancyhf{}%
  \fancyhead[L]{\sdjufont{9bp}{11.7bp}\heiti\sdju@headtitle}%
  \fancyhead[R]{\sdjufont{9bp}{11.7bp}\thepage}%
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
%   一级：黑体四号，单倍行距（行框 31.2 磅）；二级：黑体小四号，单倍行距（行框 15.6 磅），缩进 2 字符
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
\titlecontents{section}[2\ccwd]
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
% 列表：分项用 (1)、(2)、(3)…，与正文段落同样首行缩进 2 字符
% ===============================================================
\setlist{nosep}
\setlist[enumerate,1]{label=(\arabic*),leftmargin=0pt,labelindent=2em,
  itemindent=*,labelsep=0.5em,align=left,listparindent=2em}
\setlist[itemize,1]{leftmargin=0pt,labelindent=2em,itemindent=*,
  labelsep=0.5em,listparindent=2em}

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
% 封面（附件15）：各元素位置取自 Word 封面模板
% ===============================================================
\definecolor{sdjucover}{HTML}{231815}
\newcommand\sdju@coverfield[2]{%
  \makebox[4em][s]{#1}：\underline{\makebox[16em]{#2}}}
\newcommand\makecover{%
  \begin{titlepage}
  \thispagestyle{empty}%
  \begin{tikzpicture}[remember picture,overlay]
    \coordinate (T) at (current page.north);
    \node[anchor=north,inner sep=0pt] at ([yshift=-49mm]T)
      {\includegraphics[width=97.1mm]{sdju-logo}};
    \node[anchor=north,inner sep=0pt] at ([yshift=-91mm]T)
      {\sdju@yahei\fontsize{40bp}{52bp}\selectfont 学士学位论文};
    \node[anchor=north,inner sep=0pt,text width=170mm,align=center] at ([yshift=-125mm]T)
      {\sdju@yahei\fontsize{24bp}{34bp}\selectfont\sdju@title};
    \begin{scope}[every node/.style={anchor=north,inner sep=0pt,
        font=\songti\fontsize{16bp}{20.8bp}\selectfont\color{sdjucover}}]
      \node at ([yshift=-191mm]T) {\sdju@coverfield{学生姓名}{\sdju@author}};
      \node at ([yshift=-204mm]T) {\sdju@coverfield{学生学号}{\sdju@studentid}};
      \node at ([yshift=-217mm]T) {\sdju@coverfield{专\hfill 业}{\sdju@major}};
      \node at ([yshift=-230mm]T) {\sdju@coverfield{指导教师}{\sdju@supervisor}};
      \node at ([yshift=-243mm]T) {\sdju@coverfield{学\hfill 院}{\sdju@school}};
      \node at ([yshift=-267mm]T) {\sdju@coverdate};
    \end{scope}
  \end{tikzpicture}
  \end{titlepage}}

% ===============================================================
% 声明页（学术诚信声明、AI 使用情况声明、版权使用授权书）
%   全页按 2 倍行距（31.2 磅）排：空两行；标题两行（上海电机学院 / 声明名称），小二号黑体加粗居中；
%   空一行；正文四号宋体，首行缩进 2 字符；签名前空三行（AI 声明内容多，空一行）；签名与日期间空一行
% ===============================================================
\newcommand\sdju@decltitle[1]{%
  \def\sdju@chapbefore{62.4bp}%
  \def\sdju@chapafter{31.2bp+\sdju@pre{14bp}{31.2bp}}%
  \chapter*{上海电机学院\\#1}%
  \def\sdju@chapbefore{0bp}\def\sdju@chapafter{12bp}}
\newenvironment{sdju@declbody}
  {\par\sdjufont{14bp}{31.2bp}\setlength\parindent{2\ccwd}}
  {\par}
% 签名、日期行
\newcommand\sdju@date{日期：\hspace{3\ccwd}年\hspace{1.5\ccwd}月\hspace{1.5\ccwd}日}
\newcommand\sdju@signpair[2]{\noindent\makebox[0.5\linewidth][l]{#1}#2\par}
\newcommand\makedeclaration{%
  \ifsdju@opt@nodeclaration\else
  % ---- 学术诚信声明 ----
  \sdju@decltitle{毕业设计（论文）学术诚信声明}%
  \begin{sdju@declbody}
   本人郑重声明：所呈交的毕业设计（论文），是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律结果由本人承担。\par
   \vspace{3\baselineskip}
   \sdju@signpair{}{作者签名：}
   \vspace{\baselineskip}
   \sdju@signpair{}{\sdju@date}
  \end{sdju@declbody}
  % ---- AI 使用情况声明 ----
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
   \sdju@signpair{\hspace{2\ccwd}作者签名：}{指导教师签名：}
   \vspace{\baselineskip}
   \sdju@signpair{\hspace{2\ccwd}\sdju@date}{\sdju@date}
  \end{sdju@declbody}
  % ---- 版权使用授权书 ----
  \sdju@decltitle{毕业设计（论文）版权使用授权书}%
  \begin{sdju@declbody}
   本毕业设计（论文）作者同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权上海电机学院可以将本毕业设计（论文）的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本毕业设计（论文）。\par
   \hphantom{本论文属于}\hspace{2\ccwd}\textbf{保密}□，在\underline{\hspace{2\ccwd}}年解密后适用本授权书。\par
   本论文属于\par
   \hphantom{本论文属于}\hspace{2\ccwd}\textbf{不保密}□。\par
   （请在以上方框内打“√”）\par
   \vspace{3\baselineskip}
   \sdju@signpair{作者签名：}{指导教师签名：}
   \vspace{\baselineskip}
   \sdju@signpair{\sdju@date}{\sdju@date}
  \end{sdju@declbody}
  \clearpage
  \fi}

% ===============================================================
% 摘要
%   中文：标题小二号黑体居中；正文小四号宋体，首行缩进 2 字符，段前段后 12 磅，1.25 倍行距
%         （标题的段后 12 磅与首段的段前 12 磅取较大者，不叠加）；
%         「关键词：」五号黑体，关键词小四号宋体，逗号分开，最后一个后面无标点
%   英文：标题小二号 Times New Roman 加粗居中，段前 31.2 磅；正文同上；「Key words:」五号加粗
% ===============================================================
\newcommand\sdju@keywords{}
\newcommand\sdju@keywordsen{}
\newcommand\keywords[1]{\renewcommand\sdju@keywords{#1}}
\newcommand\keywordsen[1]{\renewcommand\sdju@keywordsen{#1}}
\newcommand\sdju@kwline[2]{% 悬挂缩进到标签之后
  \par\noindent\settowidth{\@tempdima}{#1}%
  \hangindent=\@tempdima\hangafter=1
  #1#2\par}
\newenvironment{abstract}
  {\sdjuchapter{摘\hspace{1em}要}\setlength{\parskip}{12bp}\vspace{-\parskip}}
  {\sdju@kwline{{\heiti\sdjufont{10.5bp}{19.5bp}关键词：}}{\sdju@keywords}%
   \setlength{\parskip}{0pt}}
\newenvironment{abstracten}
  {\sdjuchapter[][31.2bp]{\rmfamily\bfseries ABSTRACT}\setlength{\parskip}{12bp}\vspace{-\parskip}}
  {\sdju@kwline{{\rmfamily\bfseries\sdjufont{10.5bp}{19.5bp}Key words: }}{\sdju@keywordsen}%
   \setlength{\parskip}{0pt}}

% ===============================================================
% 致谢：标题小二号黑体居中；正文五号宋体，首行缩进 2 字符，单倍行距
% ===============================================================
\newenvironment{acknowledgements}
  {\sdjuchapter[致谢]{致\hspace{1em}谢}\vspace{\sdju@pre{10.5bp}{15.6bp}}\sdjufont{10.5bp}{\sdju@grid}}
  {\par}

\RequirePackage[hidelinks,bookmarksnumbered,unicode]{hyperref}
\graphicspath{{figures/}}
\endinput
