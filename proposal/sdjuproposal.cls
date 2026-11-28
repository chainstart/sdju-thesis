%% sdjuproposal.cls
%% 上海电机学院 毕业设计（论文）开题报告 LaTeX 模板
%% 依据：《教学归档材料及质量评价要素（2026 版）》附件23《毕业设计（论文）开题报告》、
%%       学校《形式审核关键点内容（26 年 5 月及之后答辩）》
%%
%% 行距约定：「单倍行距」= 15.6bp，「1.25 倍」= 19.5bp，「2 倍」= 31.2bp。
%% 编译：xelatex -> biber -> xelatex -> xelatex（或直接 latexmk proposal.tex）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjuproposal}[2026/11/27 v2.2 SDJU Thesis Proposal Template]

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
% 句末标点（. : ? !）之后与普通词距相同，不加大（\frenchspacing；Word 也不加大）。
%   放在 \AtBeginDocument 中，以免被宏包改回
\AtBeginDocument{\frenchspacing}
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
%   条目悬挂缩进 2 字符：编号顶格，转行后缩进 2 字符（按附件26「参考文献」的悬挂缩进，用户 2026-11-26
%   决定；附件23 样表的条目转行顶格，不再照搬）。字号、行距与标题在后面「参考文献」一节设定。
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
\newcommand\sdju@finaldatedefault{20\hspace{1em}年\hspace{1em}月\hspace{1em}日}
\newcommand\sdju@finaldatesrc{}
\newcommand\sdju@finaldate{\ifdefempty\sdju@finaldatesrc{\sdju@finaldatedefault}{\sdju@finaldatesrc}}
\renewcommand\title[1]{\renewcommand\sdju@title{#1}}
\newcommand\subtitle[1]{\renewcommand\sdju@subtitle{#1}}
\newcommand\school[1]{\renewcommand\sdju@school{#1}}
\newcommand\major[1]{\renewcommand\sdju@major{#1}}
\newcommand\classname[1]{\renewcommand\sdju@classname{#1}}
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\renewcommand\author[1]{\renewcommand\sdju@author{#1}}
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}% 校内指导教师
\newcommand\companysupervisor[1]{\renewcommand\sdju@companysupervisor{#1}}% 企业指导教师（无则不写，封面该栏留空）
\newcommand\finaldate[1]{\renewcommand\sdju@finaldatesrc{#1}}% 留空：空白的「20 年 月 日」

% ===============================================================
% 封面（附件23 第 1 页）：边框内自上而下逐行排，每行占一个 Word 行框（1.5 倍行距）
%   段前 18 磅；校名、「毕业设计（论文）开题报告」：一号华文中宋加粗，居中
%     （行框按附件23 中华文中宋的实际行高 1.482 × 字号计，基线在行框顶下 1.081 × 字号，
%      没有华文中宋、用宋体代替时位置不变）
%   空两行（三号）；各栏目：小二号宋体加粗，内容（小三号）写在下划线上；
%     课题名称占两行下划线（第二行为小三号行），一行写不下时第一行两边留少量空白排满、余下转到第二行（两行约 32 个汉字，
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
%   可选参数 #1：内容中心比下划线中心左移的距离的两倍（见 \sdju@coverfield）；不为 0 时内容最多
%   左移到下划线左端为止
\newcommand\sdju@coverline[3][\z@]{%
  \rlap{\rule[\dimexpr-\sdju@ulinepos-\sdju@ulinerule/2\relax]{#2}{\sdju@ulinerule}}%
  \ifdim#1=\z@
    \hbox to#2{\hss\sdjufont{15bp}{15bp}#3\hss}%
  \else
    \setbox\tw@\hbox{\sdjufont{15bp}{15bp}#3}%
    \@tempdimb=\dimexpr(#2-(#1)-\wd\tw@)/2\relax
    \ifdim\@tempdimb<\z@ \@tempdimb=\z@ \fi
    \hbox to#2{\kern\@tempdimb\box\tw@\hss}%
  \fi}
% 栏目行：#1 栏目名（盒子），#2 内容；下划线从栏目名后 0.5 字起，到右端为止。
%   填写内容的中心与四字栏目（课题名称、学院……姓名）各行的内容中心对齐（用户 2026-11-26 决定）：
%   栏目名比 4 字宽时（校内指导教师、企业指导教师），下划线照旧从栏目名之后起，内容不在本行下划线
%   上居中，而是左移到与上面各行同一条竖线上
\newcommand\sdju@coverfield[2]{%
  \sdju@coverrow{18}{\hskip\sdju@coverindent\setbox\z@\hbox{#1\hskip 0.5em}%
    \sdju@ulinew=\dimexpr\sdju@coverend-\sdju@coverindent-\wd\z@\relax
    \@tempdima=\dimexpr\wd\z@-4.5em\relax
    \box\z@\sdju@coverline[\@tempdima]{\sdju@ulinew}{#2}\hfil}}
% 课题名称第二行：小三号行，只有下划线（与第一行的下划线对齐）
\newcommand\sdju@covertitle[1]{%
  \sdju@coverrow{15}{\hskip\dimexpr\sdju@coverend-\sdju@coverw\relax\sdju@coverline{\sdju@coverw}{#1}\hfil}}
\newcommand\sdju@twochar[2]{\makebox[4em][s]{#1\hfill #2}}
% 课题名称按下划线宽度分成两行（\sdju@tla、\sdju@tlb）；小三号排不下时逐级缩小字号
\newbox\sdju@tla \newbox\sdju@tlb
\newcommand\sdju@striptail{% 去掉行与行之间的间距和惩罚，露出上一行
  \unskip\unpenalty\unskip\unpenalty\unskip\unpenalty\unskip\unpenalty\unskip}
% 封面课题名称折行（用户 2026-11-28 决定）：一行放得下照旧居中；放不下时先按词的边界分两行
%   （\sdju@wordsplit，第一行不超过下划线宽减两边各 \sdju@covertitleinset）；找不到合适的词界时，
%   第一行两边各留 \sdju@covertitleinset 少量空白、中间排满，余下的转到第二行（居中）。
\newcommand\sdju@covertitleinset{1em}
% 均衡折行（用户 2026-11-26 决定；封面与正文题目已不再使用，保留备用：长题目转行时两行长度大致相当，不让一两个字单独成行）：
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
% 题目按词的边界分成两行（用户 2026-11-28 决定）：TeX 没有中文分词，这里用题目里常见的词界：
%   「的、之、与、和、及、或、、、：、级」之后，以及常见的题目用词（系统、设计、研究、实现、发电、机组、
%   智能、数据……，见下方列表，可按需补充）之前。
%   在这些位置中取第一行最长、且两行都放得下的一处断开（第一行不超过 #2，第二行不超过 #3）；
%   一处都不行时返回“未分”，由调用者退回按字折行。题目里用 \\ 手工分行时不做处理。
%   结果：\sdju@ifws{分成了}{没分成}，两行内容在 \sdju@wsA、\sdju@wsB。
\ExplSyntaxOn
\seq_new:N \l__sdju_ws_seq
\tl_new:N \l__sdju_ws_tl
\tl_new:N \l__sdju_wsa_tl
\tl_new:N \l__sdju_wsb_tl
\tl_new:N \sdju@wsA
\tl_new:N \sdju@wsB
\box_new:N \l__sdju_ws_box
\bool_new:N \g__sdju_ws_bool
\cs_new_protected:Npn \sdju@wsmark { }
\cs_new_protected:Npn \sdju@wordsplit #1#2#3
  {
    \bool_gset_false:N \g__sdju_ws_bool
    \tl_set:No \l__sdju_ws_tl {#1}
    \tl_if_in:NnF \l__sdju_ws_tl { \\ }
      {
        \regex_replace_all:nnN { (的|之|与|和|及|或|、|：|级) } { \1\c{sdju@wsmark} } \l__sdju_ws_tl
        \regex_replace_all:nnN
          { (系统|设计|研究|实现|分析|控制|平台|装置|方法|算法|模型|技术|应用|优化|检测|监测|识别|管理|开发|仿真|评价|评估|预测|策略|机制|框架|方案|结构|电路|软件|网站|小程序|机器人|智能|自动|远程|在线|实时|无线|多功能|一体化|发电|电机|机组|风力|光伏|储能|电池|充电|数据|信息|网络|物联网|传感|控制器|监控|安全|校园|家居|环境|车辆|无人机|图像|视频|语音|深度|机器|神经|卷积|强化|嵌入式|单片机|教学|医疗|农业|工业|交通|物流|能源|材料|工艺|生产|制造|加工|测试|测量|驱动|伺服|电源|变频|变桨|偏航|液压|气动|机械|结构|零件|模具|夹具|数字|虚拟|可视化|云|边缘|移动|微信|用户|服务|调度|规划|路径|定位|导航|通信|协议) }
          { \c{sdju@wsmark}\1 } \l__sdju_ws_tl
        \seq_set_split_keep_spaces:NnV \l__sdju_ws_seq { \sdju@wsmark } \l__sdju_ws_tl
        \int_step_inline:nn { \seq_count:N \l__sdju_ws_seq - 1 }
          {
            \tl_clear:N \l__sdju_wsa_tl
            \tl_clear:N \l__sdju_wsb_tl
            \seq_map_indexed_inline:Nn \l__sdju_ws_seq
              {
                \int_compare:nNnTF {####1} > {##1}
                  { \tl_put_right:Nn \l__sdju_wsb_tl {####2} }
                  { \tl_put_right:Nn \l__sdju_wsa_tl {####2} }
              }
            \tl_trim_spaces:N \l__sdju_wsa_tl
            \tl_trim_spaces:N \l__sdju_wsb_tl
            \bool_lazy_or:nnF { \tl_if_empty_p:N \l__sdju_wsa_tl } { \tl_if_empty_p:N \l__sdju_wsb_tl }
              {
                \hbox_set:Nn \l__sdju_ws_box { \l__sdju_wsa_tl }
                \dim_compare:nNnF { \box_wd:N \l__sdju_ws_box } > {#2}
                  {
                    \hbox_set:Nn \l__sdju_ws_box { \l__sdju_wsb_tl }
                    \dim_compare:nNnF { \box_wd:N \l__sdju_ws_box } > {#3}
                      {
                        \tl_set_eq:NN \sdju@wsA \l__sdju_wsa_tl
                        \tl_set_eq:NN \sdju@wsB \l__sdju_wsb_tl
                        \bool_gset_true:N \g__sdju_ws_bool
                      }
                  }
              }
          }
      }
  }
\cs_new:Npn \sdju@ifws { \bool_if:NTF \g__sdju_ws_bool }
\ExplSyntaxOff
\newcommand\sdju@splittitle[1]{%
  \setbox\z@\vbox{\hsize=\sdju@coverw \centering \parindent=\z@
    \sdjufont{#1}{#1}\baselineskip=1.5\dimexpr#1\relax \lineskiplimit=\z@ \lineskip=\z@
    \setbox\tw@\hbox{\sdju@title}%
    \ifdim\wd\tw@>\sdju@coverw
      \sdju@wordsplit{\sdju@title}{\dimexpr\sdju@coverw-2\dimexpr\sdju@covertitleinset\relax\relax}{\sdju@coverw}%
    \else
      \sdju@wordsplit{}{\z@}{\z@}% 一行放得下：不分
    \fi
    \sdju@ifws{%
      \global\setbox\sdju@tla\hbox{\sdju@wsA}%
      \global\setbox\sdju@tlb\hbox{\sdju@wsB}%
      \global\@tempswafalse
    }{%
      \sdju@insetfirst{\sdju@covertitleinset}{\sdju@title}%
      \sdju@title\par
      \sdju@striptail \global\setbox\sdju@tlb\lastbox
      \sdju@striptail \global\setbox\sdju@tla\lastbox
      \sdju@striptail \setbox\tw@\lastbox
      \ifvoid\tw@ \global\@tempswafalse \else \global\@tempswatrue \fi}}}
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
%   课题名称：小一号宋体加粗居中（长题目第一行两边留白、其余转行）；副标题右对齐；与摘要之间约空一行
%   「摘要：」「关键词：」小四号加粗，内容小四号宋体；首行缩进 2 字符，1.25 倍行距
%   一级标题：四号宋体加粗，左对齐，1.73 倍行距（行框 31.55 磅），段前段后 13 磅（「1 文献综述」）
%   二级标题：小四号宋体，首行缩进 2 字符，段前 12 磅、段后 0 磅（与三级标题相同，用户 2026-11-26 决定；
%     紧跟在一级标题之后时不另加）（「3.1 …」）
%   正文：小四号宋体 / Times New Roman，首行缩进 2 字符，1.25 倍行距
% ===============================================================
% 正文题目折行（用户 2026-11-27 决定，取代 11-26 的均衡折行）：整宽排一行放得下时照旧一行居中；
%   放不下时第一行两边各留 \sdju@titleinset 空白、中间排满，写不下的转到下一行（整宽、居中）。
%   用 \\ 手工分行时同样只约束第一行的宽度。
\newcommand\sdju@titleinset{2em}
% 题目（含副标题）与「摘要：」之间另加的距离（用户 2026-11-27：原先贴得太近），约空一行小四号
\newcommand\sdju@titlegap{19.5bp}
\newcommand\sdju@insetfirst[2]{%
  \sdju@ballines{\hsize}{#2}%
  \ifnum\count@>\@ne
    \parshape\tw@ #1 \dimexpr\hsize-2\dimexpr#1\relax\relax \z@ \hsize
  \fi}
\renewcommand\maketitle{%
  \par
  {\centering\songti\bfseries\sdjufont{24bp}{31.2bp}%
   \setbox\z@\hbox{\sdju@title}%
   \ifdim\wd\z@>\hsize
     \sdju@wordsplit{\sdju@title}{\dimexpr\hsize-2\dimexpr\sdju@titleinset\relax\relax}{\hsize}%
   \else
     \sdju@wordsplit{}{\z@}{\z@}%
   \fi
   \sdju@ifws
     {\rule{\z@}{\sdju@above{24bp}{31.2bp}}\sdju@wsA\\\sdju@wsB\par}%
     {\sdju@insetfirst{\sdju@titleinset}{\sdju@title}%
      \rule{\z@}{\sdju@above{24bp}{31.2bp}}\sdju@title\par}}%
  % 留空判断用 \ifdefempty，不用 \ifx…\@empty：较早的 LaTeX（如 TeX Live 2022）中 \newcommand 定义的
  % 无参数宏是 \long 的，与 \@empty 用 \ifx 比较永远不等，没有副标题也会印出「——」
  \ifdefempty\sdju@subtitle{}{%
    {\raggedleft\songti\bfseries\sdjufont{24bp}{31.2bp}——\sdju@subtitle\par}}%
  \vskip\sdju@post{24bp}{31.2bp}%
  \vskip\sdju@titlegap}
\newcommand\sdju@keywords{}
\newcommand\keywords[1]{\renewcommand\sdju@keywords{#1}}
\renewenvironment{abstract}
  {\par\textbf{摘要：}\ignorespaces}
  {\par\textbf{关键词：}\sdju@keywords\par}

% 三级标题（「3.1.1 …」）：附件23 只有两级标题；学生的开题报告常用到三级。按附件26 的文字规定
%   「章节采用三级标题，用阿拉伯数字连续编号，例如 1，1.1，1.1.1」「三级标题黑体小四」排：
%   小四号黑体、不加粗，与二级标题同样首行缩进 2 字符、1.25 倍行距；与二级标题同样段前 12 磅、段后 0 磅
%   （附件26 三级标题的段前段后，用户 2026-11-26 决定；紧跟在二级标题之后时不另加）
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
    format=\sdju@headstart{12bp}{19.5bp}{12bp}{0bp}\raggedright\songti\sdjufont{12bp}{19.5bp},
    aftername=\enspace, indent=2em,
    beforeskip=12bp, afterskip=0pt, afterindent=true,
  },
  subsubsection={
    format=\sdju@headstart{12bp}{19.5bp}{12bp}{0bp}\raggedright\heiti\mdseries\sdjufont{12bp}{19.5bp},
    aftername=\enspace, indent=2em,
    beforeskip=12bp, afterskip=0pt, afterindent=true,
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
% 图表不越过一级标题：一级标题之前，先排出前面尚未排出的图表（当前页放不下就另起一页，
%   与 Word 中图片放不下时移到下一页相同），图表不会排到下一节；各级标题之后的图表不放到
%   标题所在页的上方（否则图会排在自己的标题之前）。作用同 placeins 宏包的 [section,below]。
%   二、三级标题前不强制排出（否则每遇到放不下的图表就留下半页空白）
\newcommand\sdju@floatbarrier{%
  \ifhmode\par\fi
  \begingroup\let\@elt\relax
  \edef\@tempa{\@botlist\@deferlist\@dbldeferlist}%
  \ifx\@tempa\@empty\else
    \ifx\sdju@fbagain\relax \clearpage
    \else \newpage\let\sdju@fbagain\relax\sdju@floatbarrier \fi
  \fi
  \endgroup
  \suppressfloats[t]}
\AddToHook{cmd/section/before}{\sdju@floatbarrier}
\AddToHook{cmd/subsection/before}{\suppressfloats[t]}
\AddToHook{cmd/subsubsection/before}{\suppressfloats[t]}
% 图、表、公式：按节编号；图表题与表格格式见前文
\renewcommand\thefigure{\arabic{section}-\arabic{figure}}
\renewcommand\thetable{\arabic{section}-\arabic{table}}
\renewcommand\theequation{\arabic{section}-\arabic{equation}}
\counterwithin*{figure}{section}
\counterwithin*{table}{section}
\counterwithin*{equation}{section}

% ===============================================================
% 参考文献：另起一页；标题「参考文献：」小二号黑体加粗居中，1.5 倍行距（行框 35.1 磅）；
%   条目小四号，单倍行距（15.6 磅），悬挂缩进 2 字符（著录格式、缩进与论文相同）
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
%   条目中的「[」：xeCJK 会在汉字与半角「[」之间加西文间距，手工录入的「题名[J]」排成「题名 [J]」，
%   与 .bib 方式的输出、附件23/26 的样例（「研究[J]」）不一致。环境内把「[」前面的汉字与它隔开
%   （\kern0pt），不再加间距；其他汉字与西文之间的间距照常。环境内因此不能用 \item[…] 改编号
{\catcode`\[=\active
 \gdef\sdju@refbrackets{\catcode`\[=\active \def[{\kern\z@\string[}}}
\newenvironment{references}
  {\sdju@refheading{参考文献：}%
   \sdjufont{12bp}{\sdju@grid}\begin{sdju@reflist}\sdju@refbrackets}
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
% 格子中正文第一行：基线在格子顶之下 \sdju@above{字号}（#1 为字号；在竖直模式的开头使用）。
%   不像 \rule 那样开始一个段落，内容开头的空行（\par）不会排出一个空行
\newcommand\sdju@firstline[1]{\prevdepth=\dimexpr\baselineskip-\sdju@above{#1}{\baselineskip}\relax}
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
        {\sdjufont{12bp}{15.6bp}指导教师签名：\sdju@signleft{supervisor}%
          {\dimexpr\sdju@formw-267.1bp-7em-\sdju@cellpad\relax}{24bp}};
      \node[anchor=base west,inner sep=0pt] at ([xshift=336.1bp,yshift=-\sdju@opdatey]O)
        {\sdjufont{12bp}{15.6bp}\sdju@signdatefields\sdju@supdate{supervisor}};
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
  % 意见内容：小四号，1.25 倍行距，首行缩进 2 字符；首行基线在表格顶下一个行框上部的高度处。
  %   用 \prevdepth 定第一行的位置（不另起一个空段落），意见开头有空行（\par）时也从栏目顶部排起
  \setbox\sdju@opbox\vbox{\hsize=\dimexpr\sdju@formw-24.8bp-2\dimexpr\sdju@cellpad\relax\relax
    \sdjufont{12bp}{19.5bp}\setlength\parindent{2em}\setlength\parskip{\z@}%
    \sdju@firstline{12bp}#1\par}%
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
% 意见页的栏目：和封面栏目一样，在源码中直接填写；留空（花括号内不写）时为空白表，与样表相同。
%   \supervisoropinion{意见}：指导教师意见（正文中，排出这一页）
%   \supervisordate{年}{月}{日}：指导教师意见的日期，填在「年 月 日」的空白处
%   \committeecheck{第几项}{选项}：答辩小组意见第 1～8 项中勾选的方框，选项写方框后的文字
%     （如 \committeecheck{1}{有工程背景}），也可写第几个方框（从 1 数）；留空不勾；可写多次
%   \committeeadvice{建议内容}：答辩小组结论中「建议：」下的文字（小四号，1.25 倍行距，首行缩进 2 字符）
%   \committeeresult{通过|不通过}（同 \committeeconclusion）、\committeegrade{优秀|良好|及格}：勾选答辩结论、等第
%   \committeedate{年}{月}{日}：答辩小组结论的日期
%   勾选的方框为方框内加「√」（Word 样稿用 Wingdings 2 的带勾方框）。
%   签名：没有签名配置时留空，待手签；有配置时由系统放入签名图片（指导教师 supervisor、答辩小组组长
%   committee_chair、组员 committee_member-1…，高 24 磅，紧接在「……签名：」之后，底部压在基线上；
%   组员横向排列，一行排不下时向下换行）。日期：源码中写了 \supervisordate、\committeedate 时
%   照写；没有写时取签名配置文件中的日期（答辩小组取组长、组员中最晚的），都没有时留空。
\newcommand\sdju@supdate{{}{}{}}
\newcommand\sdju@comdate{{}{}{}}
\newcommand\supervisordate[3]{\renewcommand\sdju@supdate{{#1}{#2}{#3}}}
\newcommand\committeedate[3]{\renewcommand\sdju@comdate{{#1}{#2}{#3}}}
% 日期：「年」的位置不变，年份写在「年」之前，月、日写在原来 2 字宽的空白中居中
\newcommand\sdju@datefields[1]{\expandafter\sdju@datefields@i#1}
\newcommand\sdju@datefields@i[3]{\llap{#1}年\makebox[2em]{#2}月\makebox[2em]{#3}日}
% \sdju@signdatefields\源码日期{角色列表}：源码中没有写日期时，用签名配置文件中的日期
\newcommand\sdju@nodate{{}{}{}}
\newcommand\sdju@signdatefields[2]{%
  \ifx#1\sdju@nodate
    \sdju@getdate{#2}%
    \ifsdju@hasdate \sdju@datefill{#2}{0pt}{2em}{2em}\else \sdju@datefields{#1}\fi
  \else \sdju@datefields{#1}\fi}
% 各项方框后的文字 → 第几个方框（\committeecheck 的第二个参数可写文字）
\def\sdju@defopts#1#2{\@tempcnta=\z@
  \@for\sdju@o:=#2\do{\advance\@tempcnta\@ne
    \expandafter\edef\csname sdju@opt@#1@\sdju@o\endcsname{\the\@tempcnta}}}
\sdju@defopts{1}{有理论意义,有工程背景,有实用价值,意义不大}
\sdju@defopts{2}{偏高,适当,偏低}
\sdju@defopts{3}{偏大,适当,偏小}
\sdju@defopts{4}{好,较好,一般,不可行}
\sdju@defopts{5}{好,较好,一般,较差}
\sdju@defopts{6}{好,较好,一般,较差}
\sdju@defopts{7}{好,较好,一般,较差}
\sdju@defopts{8}{好,较好,一般,较差}
\newcommand\committeecheck[2]{\ifblank{#2}{}{%
  \ifcsname sdju@opt@#1@#2\endcsname
    \@namedef{sdju@chk@#1@\csname sdju@opt@#1@#2\endcsname}{}%
  \else \@namedef{sdju@chk@#1@#2}{}\fi}}
\newcommand\sdju@comadvice{}
\newcommand\committeeadvice[1]{\renewcommand\sdju@comadvice{#1}}
\newcommand\committeeconclusion[1]{\def\@tempa{#1}\def\@tempb{通过}%
  \ifx\@tempa\@tempb\committeecheck{c}{1}\else\ifblank{#1}{}{\committeecheck{c}{2}}\fi}
\newcommand\committeeresult{\committeeconclusion}
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
    %   （排在一个 \vbox 里，用 \sdju@firstline 定第一行，建议开头有空行时也从「建议：」的下一行排起）
    \node[anchor=north west,inner sep=0pt]
      at ([xshift=\Wl+\sdju@cellpad,yshift=-12.4bp-19.5bp+\sdju@above{12bp}{19.5bp}]B)
      {\vbox{\hsize=\dimexpr\W-\Wl-2\dimexpr\sdju@cellpad\relax\relax \linewidth=\hsize
        \sdjufont{12bp}{19.5bp}\setlength\parindent{2em}\setlength\parskip{\z@}%
        \sdju@firstline{12bp}\sdju@comadvice\par}};
    % 结论：小四号，首行基线在本行顶下 28.1 磅，行距 31.2 磅（组员签名前多空半行）
    \begin{scope}[every node/.style={anchor=base west,inner sep=0pt,font=\sdjufont{12bp}{15.6bp}}]
      \node at ([xshift=\Wl+\sdju@cellpad,yshift=-28.1bp]C)
        {答辩结论：\hspace{1.5em}通过\sdju@cbox{c}{1}\hspace{5em}不通过\sdju@cbox{c}{2}};
      \node at ([xshift=\Wl+\sdju@cellpad,yshift=-28.1bp-31.2bp]C)
        {等第评定：\hspace{1.5em}优秀\sdju@cbox{g}{1}\hspace{1.5em}良好\sdju@cbox{g}{2}\hspace{1.5em}及格\sdju@cbox{g}{3}};
      \node at ([xshift=\Wl+\sdju@cellpad,yshift=-28.1bp-2*31.2bp]C) {答辩小组组长签名：%
        \sdju@signleft{committee_chair}{\dimexpr\W-\Wl-2\dimexpr\sdju@cellpad\relax-9em\relax}{24bp}};
      % 组员签名的第二行避开右侧的日期（年份写在「年」左侧）
      \node at ([xshift=\Wl+\sdju@cellpad,yshift=-28.1bp-3.5*31.2bp]C) {答辩小组组员签名：%
        \sdju@signmembers{\dimexpr\W-\Wl-2\dimexpr\sdju@cellpad\relax-9em\relax}{24bp}{6bp}{2}%
          {\dimexpr293.8bp-\Wl-\sdju@cellpad-9em-3em\relax}};
      \node at ([xshift=293.8bp,yshift=-28.1bp-4.5*31.2bp]C) {\sdju@signdatefields\sdju@comdate{\sdju@committeeroles}};
    \end{scope}
  \end{tikzpicture}\par
  \clearpage\restoregeometry\setlength\headwidth{\textwidth}}

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
      \ClassWarningNoLine{sdjuproposal}{配置文件声明了签名角色 #1，但找不到 \sdju@signdir#1.png，该处留空}#3}%
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
