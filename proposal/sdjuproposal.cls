%% sdjuproposal.cls
%% 上海电机学院 毕业设计（论文）开题报告 LaTeX 模板
%% 依据：《教学归档材料及质量评价要素（2026 版）》附件23《毕业设计（论文）开题报告》、
%%       学校《形式审核关键点内容（26 年 5 月及之后答辩）》
%%
%% 行距约定：「单倍行距」= 15.6bp，「1.25 倍」= 19.5bp，「2 倍」= 31.2bp。
%% 编译：xelatex -> biber -> xelatex -> xelatex（或直接 latexmk proposal.tex）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjuproposal}[2026/11/26 v2.1 SDJU Thesis Proposal Template]

% 页码默认在页脚右侧（2026 版附件23 样本的位置）；选项 pagenumcenter 改为页脚居中。
% pagenumright 为旧选项，保留以兼容，效果与默认相同
\newif\ifsdju@pagenumright
\sdju@pagenumrighttrue
\DeclareOption{pagenumright}{\sdju@pagenumrighttrue}
\DeclareOption{pagenumcenter}{\sdju@pagenumrightfalse}
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
\RequirePackage{fancyhdr}
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
% 字体：宋体 / 黑体 / Times New Roman，封面用华文中宋；找不到时用 Fandol / TeX Gyre Termes
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
% 华文中宋（封面的校名和标题用，一号加粗）。华文中宋的字形比宋体粗，没有它时用宋体代替，
%   代替的粗体再加重，使笔画粗细与样表的「华文中宋＋描边加粗」相当（按 2026 版 PDF 封面标定）：
%   SimSun 的伪粗体强度 \sdju@zsfakebold；Fandol 宋体粗体上再加伪粗体 \sdju@zsfandolbold
\def\sdju@zsfakebold{4.5}
\def\sdju@zsfandolbold{1.8}
\IfFontExistsTF{STZhongsong}
  {\setCJKfamilyfont{sdjuzhongsong}{STZhongsong}[AutoFakeBold=\sdju@fakebold]}
  {\IfFontExistsTF{SimSun}
    {\setCJKfamilyfont{sdjuzhongsong}{SimSun}[AutoFakeBold=\sdju@zsfakebold]}
    {\setCJKfamilyfont{sdjuzhongsong}{FandolSong-Regular.otf}
       [BoldFont=FandolSong-Bold.otf,BoldFeatures={FakeBold=\sdju@zsfandolbold}]}}
\newcommand\sdju@zhongsong{\CJKfamily{sdjuzhongsong}}

% ===============================================================
% Word 行框与 TeX 基线间距的换算
%   Word 把每一行排在一个「行框」里，段前、段后加在行框之外，相邻两段的段后与段前取较大者。
%   TeX 则直接规定相邻两行基线的距离。
%   附件23 的 Word 文件没有启用文档网格：单倍行距的行框高为 1.3 × 字号（宋体、黑体），文字在其中
%   上下居中；「x 倍行距」的行框高为 x × 1.3 × 字号，多出的部分全部加在文字下方
%   （按 2026 版 PDF 中标题、正文、参考文献各处的基线位置核对过）。所以基线到行框顶的距离
%   总是 0.65 × 字号 + 字面中心高（0.359 × 字号），与行距无关。
%   在字号或行距变化的地方（标题与正文之间）两种算法结果不同，下面的命令按 Word 的算法补上差值，
%   使这些间距只由「字号、行框高、段前、段后」决定：
%     \sdju@above{字号}{行框高}  行框中基线以上的高度
%     \sdju@below{字号}{行框高}  行框中基线以下的高度
%     \sdju@pre{字号}{行框高}    从正文行（小四号、19.5 磅）转入这种行之前应补的距离
%     \sdju@post{字号}{行框高}   从这种行回到正文行之后应补的距离
% ===============================================================
\def\sdju@emcenter{0.359}% 宋体、黑体的字面中心在基线上方 0.359 个字高处
\def\sdju@above#1#2{\dimexpr 0.65\dimexpr#1\relax+\sdju@emcenter\dimexpr#1\relax\relax}
\def\sdju@below#1#2{\dimexpr(#2)-\sdju@above{#1}{#2}\relax}
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
%   附件23 中没有图表，没有规定其格式；这里采用与学位论文格式规范（附件26）相同的做法：
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
% 参考文献：GB/T 7714-2005 顺序编码制（附件23 中的参考文献示例也是按顺序编号），\cite 为上标中括号；
%   条目不缩进：编号顶格，转行后也顶格（与附件23 一致）。字号、行距与标题在后面「参考文献」一节设定。
% ===============================================================
% 正文中的上标引用：附件23 的 2026 版 PDF 中为 6 磅（小四号的一半），基线比正文基线高 6 磅
\newcommand\sdju@supsize{6bp}
\newcommand\sdju@supraise{6bp}
\DeclareRobustCommand\sdju@sup[1]{%
  \raisebox{\sdju@supraise}{\fontsize{\sdju@supsize}{\sdju@supsize}\selectfont #1}}
\renewrobustcmd{\mkbibsuperscript}[1]{%
  \unspace\allowhyphens\sdju@sup{%
    \begingroup
    \protected\long\def\mkbibsuperscript##1{\mkbibbrackets{##1}}%
    #1\endgroup}\kern\z@}
\AtBeginBibliography{\renewcommand*{\bibpagespunct}{\addcolon}}% 页码前用冒号：1998:11-12
\AtBeginBibliography{\hyphenpenalty=10000 }% 文献样式会重设断词，这里改回不拆单词
\defbibenvironment{bibliography}
  {\list{}{%
     \setlength{\leftmargin}{\z@}\setlength{\itemindent}{\z@}%
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
     \setlength{\leftmargin}{\z@}\setlength{\itemindent}{\z@}%
     \setlength{\labelwidth}{0pt}\setlength{\labelsep}{0pt}%
     \setlength{\topsep}{0pt}\setlength{\partopsep}{0pt}%
     \setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}%
     \let\makelabel\@firstofone}%
   \hbadness=5000 }% 文献条目里不可拆的长串多，词距偏松时不必逐条警告（与 .bib 方式一致）
  {\endlist}
\newcommand\sdjucite[1]{\sdju@sup{[#1]}}

% ===============================================================
% 页面：上 2.54cm，下 2cm，左、右 2.5cm；页脚距纸边 1.25cm；
%   页码小五号，默认在页脚右侧（以 2026 版附件23 样本为准；去年的形式审核要点写「底部居中」，
%   与 2026 版冲突时以 2026 版为准），可用 pagenumcenter 选项改为居中。封面无页码
%   footskip 为版心下沿到页码基线的距离：下边距 20mm 减页脚距纸边 12.5mm，
%   再减页码行框（小五号，11.7 磅）中基线以下的部分
% ===============================================================
\geometry{a4paper,top=25.4mm,bottom=20mm,left=25mm,right=25mm,
  headheight=0pt,headsep=0pt,
  footskip=\dimexpr 20mm-12.5mm-\sdju@below{9bp}{11.7bp}\relax}
\fancypagestyle{sdjuproposal}{%
  \fancyhf{}%
  \ifsdju@pagenumright
    \fancyfoot[R]{\sdjufont{9bp}{11.7bp}\thepage}%
  \else
    \fancyfoot[C]{\sdjufont{9bp}{11.7bp}\thepage}%
  \fi
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
\newcommand\sdju@companysupervisor{}
\newcommand\sdju@finaldate{20\hspace{1em}年\hspace{1em}月\hspace{1em}日}
\renewcommand\title[1]{\renewcommand\sdju@title{#1}}
\newcommand\subtitle[1]{\renewcommand\sdju@subtitle{#1}}
\newcommand\school[1]{\renewcommand\sdju@school{#1}}
\newcommand\major[1]{\renewcommand\sdju@major{#1}}
\newcommand\classname[1]{\renewcommand\sdju@classname{#1}}
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\renewcommand\author[1]{\renewcommand\sdju@author{#1}}
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}% 校内指导教师
\newcommand\companysupervisor[1]{\renewcommand\sdju@companysupervisor{#1}}% 企业指导教师（无则不写，封面该栏留空）
\newcommand\finaldate[1]{\renewcommand\sdju@finaldate{#1}}

% ===============================================================
% 封面（附件23 第 1 页）：边框内自上而下逐行排，每行占一个 Word 行框（1.5 倍行距）
%   段前 18 磅；校名、「毕业设计（论文）开题报告」：一号华文中宋加粗，居中
%     （行框按附件23 中华文中宋的实际行高 1.482 × 字号计，基线在行框顶下 1.081 × 字号，
%      没有华文中宋、用宋体代替时位置不变）
%   空两行（三号）；各栏目：小二号宋体加粗，内容（小三号）写在下划线上；
%     课题名称占两行下划线（第二行为小三号行），一行写不下时自动转到第二行（两行约 34 个汉字，
%     再长则自动缩小字号）
%   栏目依次为课题名称、学院、专业、班级、学号、姓名、校内指导教师、企业指导教师；
%     两字栏目名撑满 4 字宽，其余按实际宽度；下划线右端对齐（距纸边 469.5 磅）
%   空两行（三号）；定稿日期：小三号宋体加粗
% ===============================================================
\newcommand\sdju@coverindent{19mm}%   栏目名距版心左边
\newcommand\sdju@coverend{398.6bp}%   下划线右端距版心左边（距纸边 469.5 磅）
\newlength\sdju@coverw % 课题名称下划线长度（与两字、四字栏目的下划线等长；4 字宽与 0.5 字按小二号计）
\setlength\sdju@coverw{\dimexpr\sdju@coverend-\sdju@coverindent-4\dimexpr18bp\relax-9bp\relax}
\newlength\sdju@ulinew
% 一行：#1 字号（bp 数值），#2 内容。行框高 1.5 × 1.3 × 字号（1.95 × 字号），
%   基线在行框顶下 0.65 × 字号 + 0.359 × 字号（约 1 个字号）处
\newcommand\sdju@coverrow[2]{%
  \hbox to\hsize{\vrule width\z@ height \sdju@above{#1bp}{0bp} depth \dimexpr1.95\dimexpr#1bp\relax-\sdju@above{#1bp}{0bp}\relax
    \sdjufont{#1bp}{#1bp}#2}}
% 校名行（华文中宋）：行框高 1.5 × 1.482 × 字号，基线在行框顶下 1.081 × 字号
\newcommand\sdju@coverheadrow[2]{%
  \hbox to\hsize{\vrule width\z@ height 1.081\dimexpr#1bp\relax depth 1.142\dimexpr#1bp\relax
    \sdjufont{#1bp}{#1bp}#2}}
% 一条下划线及写在上面的内容（居中，小三号）：#1 长度，#2 内容
%   下划线线粗 \sdju@ulinerule，中线在栏目基线之下 \sdju@ulinepos（附件23 中为 1.7～2.2 磅，取 1.9 磅）
\newcommand\sdju@ulinepos{1.9bp}
\newcommand\sdju@ulinerule{0.72bp}
\newcommand\sdju@coverline[2]{%
  \rlap{\rule[\dimexpr-\sdju@ulinepos-\sdju@ulinerule/2\relax]{#1}{\sdju@ulinerule}}%
  \hbox to#1{\hss\sdjufont{15bp}{15bp}#2\hss}}
% 栏目行：#1 栏目名（盒子），#2 内容；下划线从栏目名后 0.5 字起，到右端为止
\newcommand\sdju@coverfield[2]{%
  \sdju@coverrow{18}{\hskip\sdju@coverindent\setbox\z@\hbox{#1\hskip 0.5em}%
    \sdju@ulinew=\dimexpr\sdju@coverend-\sdju@coverindent-\wd\z@\relax
    \box\z@\sdju@coverline{\sdju@ulinew}{#2}\hfil}}
% 课题名称第二行：小三号行，只有下划线（与第一行的下划线对齐）
\newcommand\sdju@covertitle[1]{%
  \sdju@coverrow{15}{\hskip\dimexpr\sdju@coverend-\sdju@coverw\relax\sdju@coverline{\sdju@coverw}{#1}\hfil}}
\newcommand\sdju@twochar[2]{\makebox[4em][s]{#1\hfill #2}}
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
    \draw[line width=0.4bp]
      ([xshift=70.7bp,yshift=-71.8bp]current page.north west) rectangle
      ([xshift=512.1bp,yshift=-696.2bp]current page.north west);
  \end{tikzpicture}%
  \vbox to\z@{\offinterlineskip
    \vskip\dimexpr 18bp-\topskip\relax
    \sdju@coverheadrow{26}{\hfil\sdju@zhongsong 上海电机学院\hfil}%
    \sdju@coverheadrow{26}{\hfil\sdju@zhongsong 毕业设计（论文）开题报告\hfil}%
    \vskip 62.4bp
    \ifvoid\sdju@tla
      \sdju@coverfield{课题名称}{\box\sdju@tlb}%
      \sdju@covertitle{}%
    \else
      \sdju@coverfield{课题名称}{\box\sdju@tla}%
      \sdju@covertitle{\box\sdju@tlb}%
    \fi
    \sdju@coverfield{\sdju@twochar 学院}{\sdju@school}%
    \sdju@coverfield{\sdju@twochar 专业}{\sdju@major}%
    \sdju@coverfield{\sdju@twochar 班级}{\sdju@classname}%
    \sdju@coverfield{\sdju@twochar 学号}{\sdju@studentid}%
    \sdju@coverfield{\sdju@twochar 姓名}{\sdju@author}%
    \sdju@coverfield{校内指导教师}{\sdju@supervisor}%
    \sdju@coverfield{企业指导教师}{\sdju@companysupervisor}%
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
%   一级标题：四号宋体加粗，左对齐，1.73 倍行距（行框 31.55 磅），段前段后 13 磅（「1 文献综述」）
%   二级标题：小四号宋体，首行缩进 2 字符（「3.1 …」）
%   正文：小四号宋体 / Times New Roman，首行缩进 2 字符，1.25 倍行距
% ===============================================================
\renewcommand\maketitle{%
  \par
  {\centering\songti\bfseries\sdjufont{24bp}{31.2bp}%
   \rule{\z@}{\sdju@above{24bp}{31.2bp}}\sdju@title\par}%
  \ifx\sdju@subtitle\@empty\else
    {\raggedleft\songti\bfseries\sdjufont{24bp}{31.2bp}——\sdju@subtitle\par}%
  \fi
  \vskip\sdju@post{24bp}{31.2bp}}
\newcommand\sdju@keywords{}
\newcommand\keywords[1]{\renewcommand\sdju@keywords{#1}}
\renewenvironment{abstract}
  {\par\textbf{摘要：}\ignorespaces}
  {\par\textbf{关键词：}\sdju@keywords\par}

% 三级标题（「3.1.1 …」）：附件23 只有两级标题；学生的开题报告常用到三级。按附件26 的文字规定
%   「章节采用三级标题，用阿拉伯数字连续编号，例如 1，1.1，1.1.1」「三级标题黑体小四」排：
%   小四号黑体、不加粗，与二级标题同样首行缩进 2 字符、1.25 倍行距，段前段后与二级标题一致（0 磅），
%   使开题报告内各级标题的间距统一
\setcounter{secnumdepth}{3}
\def\sdju@secbox{31.55bp}% 一级标题行框：Word 中为 1.73 倍行距（416/240），1.733 × 1.3 × 14 磅
\ctexset{
  section={
    format=\sdju@headstart{14bp}{\sdju@secbox}{13bp}{13bp}\raggedright\songti\bfseries\sdjufont{14bp}{\sdju@secbox},
    name={,}, number=\arabic{section}, aftername=\enspace,
    beforeskip=\dimexpr 13bp+\sdju@pre{14bp}{\sdju@secbox}\relax,
    afterskip=\dimexpr 13bp+\sdju@post{14bp}{\sdju@secbox}\relax,
    indent=0pt, afterindent=true,
  },
  subsection={
    format=\sdju@headstart{12bp}{19.5bp}{0bp}{0bp}\raggedright\songti\sdjufont{12bp}{19.5bp},
    aftername=\enspace, indent=2em,
    beforeskip=0pt, afterskip=0pt, afterindent=true,
  },
  subsubsection={
    format=\sdju@headstart{12bp}{19.5bp}{0bp}{0bp}\raggedright\heiti\mdseries\sdjufont{12bp}{19.5bp},
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

% 编号列表（各模板统一）：全角括号「（1）」「（2）」…，编号后紧接内容（全角括号自带半字空白），
%   首行与正文同样缩进 \sdju@listindent，转行回到左边。依据与取舍见 README「编号列表」
\newcommand\sdju@listindent{2em}
\setlist{nosep}
\setlist[enumerate,1]{label=（\arabic*）,leftmargin=0pt,labelindent=\sdju@listindent,
  itemindent=*,labelsep=0pt,align=left,listparindent=\sdju@listindent}
\setlist[itemize,1]{leftmargin=0pt,labelindent=\sdju@listindent,itemindent=*,
  labelsep=0.5em,listparindent=\sdju@listindent}

% 浮动体的放置：LaTeX 默认凡占半页以上的图表都可单独成页（floatpagefraction = 0.5），
%   开题报告中半页多的表格、流程图因此常独占一页、下方留出大片空白，后文却排在下一页。
%   改为：图表可占页面上方 90%（topfraction），正文至少留 10%；只有占页面 80% 以上的图表
%   才单独成页，其余放在页面上方，下面接排正文
\renewcommand\topfraction{.9}
\renewcommand\bottomfraction{.6}
\renewcommand\textfraction{.1}
\renewcommand\floatpagefraction{.8}
\setcounter{topnumber}{3}
\setcounter{totalnumber}{4}
% 图、表、公式：按节编号；图表题与表格格式见前文
\renewcommand\thefigure{\arabic{section}-\arabic{figure}}
\renewcommand\thetable{\arabic{section}-\arabic{table}}
\renewcommand\theequation{\arabic{section}-\arabic{equation}}
\counterwithin*{figure}{section}
\counterwithin*{table}{section}
\counterwithin*{equation}{section}

% ===============================================================
% 参考文献：另起一页；标题「参考文献：」小二号黑体加粗居中，1.5 倍行距（行框 35.1 磅）；
%   条目小四号，单倍行距（15.6 磅），不缩进（著录格式与论文相同）
% ===============================================================
\newcommand\sdju@refheading[1]{%
  \clearpage
  {\centering\heiti\bfseries\sdjufont{18bp}{35.1bp}\rule{\z@}{\sdju@above{18bp}{35.1bp}}#1\par}%
  % 标题行框底到第一条文献基线：标题行框中基线以下的部分 + 文献行框中基线以上的部分
  \vskip\dimexpr\sdju@below{18bp}{35.1bp}+\sdju@above{12bp}{\sdju@grid}-\sdju@grid\relax}
\defbibheading{sdjuproposal}[参考文献：]{\sdju@refheading{#1}}
\AtBeginBibliography{\sdjufont{12bp}{\sdju@grid}}
\newcommand\sdjubibliography{\printbibliography[heading=sdjuproposal]}
% 不用 .bib 文献库时，手工录入：\begin{references} \item 作者. 题名[J]. …… \end{references}
% 条目自动编号 [1]、[2]…；正文中用 \sdjucite{1} 标注
\newenvironment{references}
  {\sdju@refheading{参考文献：}%
   \sdjufont{12bp}{\sdju@grid}\begin{sdju@reflist}}
  {\end{sdju@reflist}}

% ===============================================================
% 意见页（每张表占一页）：左侧为竖排栏目名，右侧为填写区；尺寸按附件23 第 5、6 页量取
%   \supervisoropinion{<意见内容，可留空>}：指导教师意见
%     表格比版心左右各宽 5.4 磅（Word 表格的单元格边距），高 622.9 磅；栏目名格宽 24.8 磅，
%     栏目名小四号、每字一行、行距 31.2 磅，整体上下居中（按 Word 的行框，字在行框上部）
%   \committeeopinion：答辩小组意见与结论
%     这一页在附件23 中单独成节：左右边距 3.17cm，上下 2.54cm，页脚距纸边 1.75cm；
%     表格宽 400.6 磅（左边线在版心左边内 5 磅），三行高 241.0、239.7、172.1 磅；
%     栏目名格宽 41.7 磅，栏目名五号、每行两字、行距 31.2 磅，在格内上下居中；
%     评议项目五号、行距 20 磅；结论各行小四号、行距 31.2 磅
% ===============================================================
\newlength\sdju@formw \newlength\sdju@formx \newlength\sdju@formy
\tikzset{sdjuform/.style={line width=0.48bp}}% 表格线粗（附件23 为 0.48 磅）
\newcommand\sdju@cellpad{5.4bp}% 单元格左右内边距
% 竖排栏目名：#1 格宽，#2 字号，#3 行距，#4 基线到行框顶的距离，#5 各行（逗号分开）
\newcommand\sdju@vlabel[5]{%
  \vbox{\offinterlineskip
    \@for\sdju@ln:=#5\do{%
      \hbox to#1{\hss\vrule width\z@ height #4 depth\dimexpr#3-#4\relax
        \sdjufont{#2}{#2}\sdju@ln\hss}}}}
%   意见内容多、写到签名处时，表格续排到下一页：续页是同样大小的表格（不重复栏目名），
%   内容从表格顶部接着排，签名和日期在最后一页的原位置；每页内容至多排到表格底部之上
%   \sdju@opbottom 处，最后一页的内容与签名之间至少留一行（\sdju@opsignroom 为最后一页内容的最大高度）
\newcommand\sdju@opH{622.9bp}%        表格高度
\newcommand\sdju@opsigny{507.4bp}%    「指导教师签名：」基线距表格顶
\newcommand\sdju@opdatey{534.9bp}%    「年 月 日」基线距表格顶
\newcommand\sdju@opsignroom{\dimexpr\sdju@opsigny-2\dimexpr19.5bp\relax\relax}
\newcommand\sdju@opbottom{8bp}
\newbox\sdju@opbox \newbox\sdju@oppiece
\newif\ifsdju@opfirst
% 排一页意见表：#1 为 1 时印栏目名，#2 为 1 时印签名和日期；内容在 \sdju@oppiece 中
\newcommand\sdju@oppage[2]{%
  \clearpage
  \noindent\begin{tikzpicture}[remember picture,overlay,sdjuform]
    \coordinate (O) at ([xshift=\sdju@formx,yshift=-\sdju@formy]current page.north west);
    \draw (O) rectangle ++(\sdju@formw,-\sdju@opH);
    \draw ([xshift=24.8bp]O) -- ++(0,-\sdju@opH);
    \ifnum#1=\@ne
      \node[inner sep=0pt] at ([xshift=12.4bp,yshift=-0.5*\sdju@opH]O)
        {\sdju@vlabel{24.8bp}{12bp}{31.2bp}{\sdju@above{12bp}{31.2bp}}{指,导,教,师,意,见}};
    \fi
    \node[anchor=north west,inner sep=0pt] at ([xshift=24.8bp+\sdju@cellpad]O) {\box\sdju@oppiece};
    \ifnum#2=\@ne
      \node[anchor=base west,inner sep=0pt] at ([xshift=267.1bp,yshift=-\sdju@opsigny]O)
        {\sdjufont{12bp}{15.6bp}指导教师签名：};
      \node[anchor=base west,inner sep=0pt] at ([xshift=336.1bp,yshift=-\sdju@opdatey]O)
        {\sdjufont{12bp}{15.6bp}\sdju@datefields{\sdju@supdate}};
    \fi
  \end{tikzpicture}\par}
\newcommand\sdju@oploop{%
  \@tempdima=\dimexpr\ht\sdju@opbox+\dp\sdju@opbox\relax
  \ifdim\@tempdima>\sdju@opsignroom
    \setbox\sdju@oppiece\vsplit\sdju@opbox to\dimexpr\sdju@opH-\sdju@opbottom\relax
    \setbox\sdju@oppiece\vbox{\unvbox\sdju@oppiece}%
    \sdju@oppage{\ifsdju@opfirst 1\else 0\fi}{0}%
    \sdju@opfirstfalse
    \expandafter\sdju@oploop
  \else
    \setbox\sdju@oppiece\box\sdju@opbox
    \sdju@oppage{\ifsdju@opfirst 1\else 0\fi}{1}%
  \fi}
\newcommand\supervisoropinion[1]{%
  \clearpage
  \begingroup
  \setlength\sdju@formw{\dimexpr\textwidth+2\dimexpr\sdju@cellpad\relax\relax}%
  % 表格左上角：版心左边外 5.4 磅，版心上边下 0.3 磅
  \setlength\sdju@formx{\dimexpr1in+\oddsidemargin+\hoffset-\sdju@cellpad\relax}%
  \setlength\sdju@formy{\dimexpr1in+\topmargin+\voffset+\headheight+\headsep+0.3bp\relax}%
  % 意见内容：小四号，1.25 倍行距，首行缩进 2 字符；首行基线在表格顶下一个行框上部的高度处
  \setbox\sdju@opbox\vbox{\hsize=\dimexpr\sdju@formw-24.8bp-2\dimexpr\sdju@cellpad\relax\relax
    \sdjufont{12bp}{19.5bp}\setlength\parindent{2em}\setlength\parskip{\z@}%
    \rule{\z@}{\sdju@above{12bp}{19.5bp}}#1\par}%
  \splittopskip=\sdju@above{12bp}{19.5bp}\relax
  \vbadness=\@M
  \sdju@opfirsttrue
  \sdju@oploop
  \endgroup}
% 方框「□」：有宋体时直接用宋体的 □（附件23 即宋体的 □）；只有 Fandol 时按宋体的 □ 画出
%   （边长 0.71 字、线粗 0.04 字，底边在基线上，左边距 0.14 字，占 1 字宽），
%   不用 Fandol 的 □（几乎占满整个字身，比样表大得多）
\ifsdju@realfonts
  \newcommand\sdju@box{□}
\else
  \newcommand\sdju@box{\makebox[1em][l]{\hspace{0.14em}%
    \fboxsep=\z@\fboxrule=0.04em\framebox{\rule{0pt}{0.63em}\rule{0.63em}{0pt}}}}
\fi
% 意见页的填写内容（可选；不写时为空白表，与样表相同）。用于把已经填好的开题报告（如往届归档稿）
%   原样录入；正常流程中这些内容由指导教师、答辩小组在打印稿上手写。
%   \supervisordate{年}{月}{日}：指导教师意见的日期，填在「年 月 日」的空白处
%   \committeecheck{第几项}{第几个方框}：答辩小组意见第 1～8 项中勾选的方框（从 1 数），可写多次
%   \committeeadvice{建议内容}：答辩小组结论中「建议：」下的文字（小四号，1.25 倍行距，首行缩进 2 字符）
%   \committeeconclusion{通过|不通过}、\committeegrade{优秀|良好|及格}：勾选答辩结论、等第
%   \committeedate{年}{月}{日}：答辩小组结论的日期
%   签名一律手签，模板不放签名图片。勾选的方框为方框内加「√」（Word 样稿用 Wingdings 2 的带勾方框）
\newcommand\sdju@supdate{{}{}{}}
\newcommand\sdju@comdate{{}{}{}}
\newcommand\supervisordate[3]{\renewcommand\sdju@supdate{{#1}{#2}{#3}}}
\newcommand\committeedate[3]{\renewcommand\sdju@comdate{{#1}{#2}{#3}}}
% 日期：「年」的位置不变，年份写在「年」之前，月、日写在原来 2 字宽的空白中居中
\newcommand\sdju@datefields[1]{\expandafter\sdju@datefields@i#1}
\newcommand\sdju@datefields@i[3]{\llap{#1}年\makebox[2em]{#2}月\makebox[2em]{#3}日}
\newcommand\committeecheck[2]{\@namedef{sdju@chk@#1@#2}{}}
\newcommand\sdju@comadvice{}
\newcommand\committeeadvice[1]{\renewcommand\sdju@comadvice{#1}}
\newcommand\committeeconclusion[1]{\def\@tempa{#1}\def\@tempb{通过}%
  \ifx\@tempa\@tempb\committeecheck{c}{1}\else\committeecheck{c}{2}\fi}
\newcommand\committeegrade[1]{\def\@tempa{#1}%
  \def\@tempb{优秀}\ifx\@tempa\@tempb\committeecheck{g}{1}\fi
  \def\@tempb{良好}\ifx\@tempa\@tempb\committeecheck{g}{2}\fi
  \def\@tempb{及格}\ifx\@tempa\@tempb\committeecheck{g}{3}\fi}
% \sdju@cbox{项}{第几个}：未勾选时与 \sdju@box 完全相同
\newcommand\sdju@cbox[2]{\@ifundefined{sdju@chk@#1@#2}{\sdju@box}%
  {\makebox[1em][l]{\sdju@box}\llap{\makebox[1em][c]{\raisebox{0.06em}{\fontsize{0.8em}{0.8em}\selectfont √}}}}}
\newcommand\committeeopinion{%
  \newgeometry{top=72bp,bottom=72bp,left=90bp,right=90bp,headheight=0pt,headsep=0pt,
    footskip=\dimexpr 72bp-49.6bp-\sdju@below{9bp}{11.7bp}\relax}%
  \setlength\headwidth{\textwidth}% 页码随本页的版心右边对齐
  \noindent\begin{tikzpicture}[remember picture,overlay,sdjuform]
    \def\Ha{241bp}\def\Hb{239.7bp}\def\Hc{172.1bp}\def\Wl{41.7bp}\def\W{400.6bp}
    \coordinate (O) at ([xshift=95bp,yshift=-72.3bp]current page.north west);% 表格左上角
    \coordinate (B) at ([yshift=-\Ha]O);% 第二行（建议）顶
    \coordinate (C) at ([yshift=-\Ha-\Hb]O);% 第三行（结论）顶
    \draw (O) rectangle ++(\W,-\Ha-\Hb-\Hc);
    \draw ([xshift=\Wl]O) -- ++(0,-\Ha-\Hb-\Hc);
    \draw (B) -- ++(\W,0);
    \draw ([xshift=\Wl]C) -- ++(\W-\Wl,0);
    \node[inner sep=0pt] at ([xshift=0.5*\Wl,yshift=-0.5*\Ha]O)
      {\sdju@vlabel{\Wl}{10.5bp}{31.2bp}{\dimexpr15.6bp+0.359\dimexpr10.5bp\relax\relax}{答辩,小组,意见}};
    \node[inner sep=0pt] at ([xshift=0.5*\Wl,yshift=-0.5*\Hb-0.5*\Hc]B)
      {\sdju@vlabel{\Wl}{10.5bp}{31.2bp}{\dimexpr15.6bp+0.359\dimexpr10.5bp\relax\relax}{答辩,小组,结论}};
    % 答辩小组意见：五号，行距 20 磅，首行基线在表顶下 16.2 磅
    \node[anchor=north west,inner sep=0pt,text width=\W-\Wl-2*\sdju@cellpad]
      at ([xshift=\Wl+\sdju@cellpad]O) {\sdjufont{10.5bp}{20bp}\setlength\parindent{0pt}%
      \rule{\z@}{16.2bp}1、论文选题：\sdju@cbox{1}{1}有理论意义；\sdju@cbox{1}{2}有工程背景；\sdju@cbox{1}{3}有实用价值；\sdju@cbox{1}{4}意义不大。\par
      2、论文的难度：\sdju@cbox{2}{1}偏高；\sdju@cbox{2}{2}适当；\sdju@cbox{2}{3}偏低。\par
      3、论文的工作量：\sdju@cbox{3}{1}偏大；\sdju@cbox{3}{2}适当；\sdju@cbox{3}{3}偏小。\par
      4、设计或研究方案的可行性：\sdju@cbox{4}{1}好；\sdju@cbox{4}{2}较好；\sdju@cbox{4}{3}一般；\sdju@cbox{4}{4}不可行。\par
      5、学生对文献资料及课题的了解程度：\sdju@cbox{5}{1}好；\sdju@cbox{5}{2}较好；\sdju@cbox{5}{3}一般；\sdju@cbox{5}{4}较差。\par
      6、学生在论文选题报告中反映出的综合能力和表达能力：\par
      \hspace*{3.5em}\sdju@cbox{6}{1}好；\sdju@cbox{6}{2}较好；\sdju@cbox{6}{3}一般；\sdju@cbox{6}{4}较差。\par
      7、学生在论文选题报告中反映出的创新能力：\par
      \hspace*{3.5em}\sdju@cbox{7}{1}好；\sdju@cbox{7}{2}较好；\sdju@cbox{7}{3}一般；\sdju@cbox{7}{4}较差。\par
      8、对论文选题报告的总体评价：\sdju@cbox{8}{1}好；\sdju@cbox{8}{2}较好；\sdju@cbox{8}{3}一般；\sdju@cbox{8}{4}较差\par
      \vskip 11.2bp（在相应的方块内作记号“√”）\par};
    % 建议：小四号，基线在本行顶下 12.4 磅
    \node[anchor=base west,inner sep=0pt] at ([xshift=\Wl+\sdju@cellpad,yshift=-12.4bp]B)
      {\sdjufont{12bp}{15.6bp}建议：};
    % 建议内容：从「建议：」的下一行起排（行距 19.5 磅）
    \node[anchor=north west,inner sep=0pt,text width=\W-\Wl-2*\sdju@cellpad]
      at ([xshift=\Wl+\sdju@cellpad,yshift=-12.4bp-19.5bp+\sdju@above{12bp}{19.5bp}]B)
      {\sdjufont{12bp}{19.5bp}\setlength\parindent{2em}\rule{\z@}{\sdju@above{12bp}{19.5bp}}\sdju@comadvice\par};
    % 结论：小四号，首行基线在本行顶下 28.1 磅，行距 31.2 磅（组员签名前多空半行）
    \begin{scope}[every node/.style={anchor=base west,inner sep=0pt,font=\sdjufont{12bp}{15.6bp}}]
      \node at ([xshift=\Wl+\sdju@cellpad,yshift=-28.1bp]C)
        {答辩结论：\hspace{1.5em}通过\sdju@cbox{c}{1}\hspace{5em}不通过\sdju@cbox{c}{2}};
      \node at ([xshift=\Wl+\sdju@cellpad,yshift=-28.1bp-31.2bp]C)
        {等第评定：\hspace{1.5em}优秀\sdju@cbox{g}{1}\hspace{1.5em}良好\sdju@cbox{g}{2}\hspace{1.5em}及格\sdju@cbox{g}{3}};
      \node at ([xshift=\Wl+\sdju@cellpad,yshift=-28.1bp-2*31.2bp]C) {答辩小组组长签名：};
      \node at ([xshift=\Wl+\sdju@cellpad,yshift=-28.1bp-3.5*31.2bp]C) {答辩小组组员签名：};
      \node at ([xshift=293.8bp,yshift=-28.1bp-4.5*31.2bp]C) {\sdju@datefields{\sdju@comdate}};
    \end{scope}
  \end{tikzpicture}\par
  \clearpage\restoregeometry\setlength\headwidth{\textwidth}}

\RequirePackage[hidelinks,unicode]{hyperref}
\graphicspath{{figures/}}
\endinput
