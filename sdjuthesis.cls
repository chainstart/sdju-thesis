%% sdjuthesis.cls
%% 上海电机学院 学士学位论文 LaTeX 模板
%% 依据：附件15《学士学位论文封面》、附件17《毕业设计（论文）格式规范》、《论文格式-无红色标注.pdf》
%% 编译：xelatex -> biber -> xelatex -> xelatex（或直接 latexmk）
%%
%% 行距约定：Word 文档网格为 15.6 磅，「单倍行距」= 15.6bp，「1.25 倍」= 19.5bp，「2 倍」= 31.2bp。
%% 本文件中的格式参数集中在「格式参数」一节，修改格式只需改那里。
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjuthesis}[2026/11/01 v2.1 SDJU Bachelor Thesis Template]

% ---------------------------------------------------------------
% 选项：nodeclaration 不输出声明页
% ---------------------------------------------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=sdju,prefix=sdju@opt@}
\DeclareBoolOption{nodeclaration}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*

\LoadClass[UTF8,a4paper,oneside,openany,zihao=-4,linespread=1,fontset=none]{ctexbook}

\RequirePackage{sdjubase}

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
% 标题
%   一级：小二号黑体加粗，居中，段前 0、段后 12 磅，每章另起页
%   二级：四号宋体，左对齐（首行缩进 2 字符），段前 12、段后 0 磅
%   三级：小四号黑体，左对齐（首行缩进 2 字符），段前 12、段后 0 磅
% ===============================================================
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{1}
\ctexset{
  chapter={
    format=\centering\heiti\bfseries\sdjufont{18bp}{31.2bp}\rule{0pt}{0.7\baselineskip},% 小二号超过一格网格，按两格（2×15.6）排行
    nameformat={}, titleformat={},
    name={,}, number=\arabic{chapter}, aftername=\enspace,
    beforeskip=0pt, afterskip=12bp, fixskip=true,
    afterindent=true, pagestyle=sdju,
  },
  section={
    format=\raggedright\songti\sdjufont{14bp}{\sdju@grid},
    aftername=\enspace, indent=2em,
    beforeskip=12bp, afterskip=1sp, afterindent=true,
  },
  subsection={
    format=\raggedright\heiti\sdjufont{12bp}{\sdju@grid},
    aftername=\enspace, indent=2em,
    beforeskip=12bp, afterskip=1sp, afterindent=true,
  },
  bibname={参考文献},
  figurename={图},
  tablename={表},
}
% 不编号的一级标题；可选参数为目录中显示的文字（省略或留空则不进目录）
% 第二个可选参数为标题前的段前距离（默认 0）
\NewDocumentCommand\sdjuchapter{o O{0pt} m}{%
  \begingroup
    \ctexset{chapter/beforeskip={#2}}%
    \chapter*{#3}%
  \endgroup
  \IfValueT{#1}{\if\relax\detokenize{#1}\relax\else\addcontentsline{toc}{chapter}{#1}\fi}%
  \markboth{}{}}

% ===============================================================
% 目录：标题小二号黑体加粗居中，段前 31.2 磅、段后 12 磅；列出一、二级标题
%   一级：黑体四号；二级：黑体小四号，缩进 2 字符；引导线为短横线；页码统一为五号 Times New Roman
% ===============================================================
\newcommand\sdju@tocpage[1]{{\sdjufont{10.5bp}{10.5bp}\rmfamily #1}}
\newcommand\sdju@tocdots{\leaders\hbox{\sdjufont{10.5bp}{10.5bp}\rmfamily -}\hfill}% 引导线：短横线
\contentsmargin{0pt}
\titlecontents{chapter}[0pt]
  {\heiti\sdjufont{14bp}{19.5bp}}
  {\thecontentslabel\enspace}{}
  {\sdju@tocdots\sdju@tocpage{\thecontentspage}}
\titlecontents{section}[2\ccwd]
  {\heiti\sdjufont{12bp}{19.5bp}}
  {\thecontentslabel\enspace}{}
  {\sdju@tocdots\sdju@tocpage{\thecontentspage}}
\newcommand\sdjutableofcontents{%
  \sdjuchapter[][31.2bp]{目\hspace{1em}录}%
  \begingroup\setlength\parindent{0pt}\@starttoc{toc}\endgroup
  \clearpage}

% ===============================================================
% 图、表、公式：按章编号（图2-1、表2-1、（2-1））
%   表名在表正上方，图名在图正下方，均为宋体小五号加粗；表格为三线表
% ===============================================================
\renewcommand\thefigure{\thechapter-\arabic{figure}}
\renewcommand\thetable{\thechapter-\arabic{table}}
\renewcommand\theequation{\thechapter-\arabic{equation}}
\DeclareCaptionFont{sdjucap}{\songti\sdjufont{9bp}{\sdju@grid}\bfseries}
\captionsetup{font=sdjucap,labelsep=space,justification=centering,singlelinecheck=false}
\captionsetup[table]{position=top,skip=4bp}
\captionsetup[figure]{position=bottom,skip=6bp}
\newcommand\sdjutablesetup{%
  \sdjufont{12bp}{\sdju@grid}%
  \renewcommand\arraystretch{1}%
  \setlength\heavyrulewidth{0.5bp}\setlength\lightrulewidth{0.5bp}}
\AtBeginEnvironment{table}{\sdjutablesetup}
\AtBeginEnvironment{longtable}{\sdjutablesetup}
\AtBeginEnvironment{figure}{\sdjufont{12bp}{\sdju@grid}}
% 公式编号使用全角括号
\renewcommand\tagform@[1]{\maketag@@@{（\ignorespaces#1\unskip\@@italiccorr）}}
% 跨页表格：在 longtable 的续页表头中使用 \sdjucontinued{<列数>}，右上方显示「续表x-x」
\newcommand\sdjucontinued[1]{%
  \multicolumn{#1}{r}{\sdjufont{12bp}{\sdju@grid}续表\thetable}\\}

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
%   标题：小二号黑体加粗居中（两行：上海电机学院 / 声明名称）
%   正文：四号宋体，首行缩进 2 字符，2 倍行距
% ===============================================================
\newcommand\sdju@decltitle[1]{%
  \null\vspace{1.5\baselineskip}%
  {\centering\heiti\bfseries\sdjufont{18bp}{31.2bp}上海电机学院\par #1\par}%
  \vspace{18bp}}
\newenvironment{sdju@declbody}
  {\par\sdjufont{14bp}{31.2bp}\setlength\parindent{2\ccwd}}
  {\par}
% 签名、日期行
\newcommand\sdju@date{日期：\hspace{3\ccwd}年\hspace{1.5\ccwd}月\hspace{1.5\ccwd}日}
\newcommand\sdju@signpair[2]{\noindent\makebox[0.5\linewidth][l]{#1}#2\par}
\newcommand\makedeclaration{%
  \ifsdju@opt@nodeclaration\else
  % ---- 学术诚信声明 ----
  \clearpage
  \sdju@decltitle{毕业设计（论文）学术诚信声明}%
  \begin{sdju@declbody}
   本人郑重声明：所呈交的毕业设计（论文），是本人在导师的指导下，独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律结果由本人承担。\par
   \vspace{2\baselineskip}
   \sdju@signpair{}{作者签名：}
   \vspace{0.5\baselineskip}
   \sdju@signpair{}{\sdju@date}
  \end{sdju@declbody}
  % ---- AI 使用情况声明 ----
  \clearpage
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
   \vspace{0.5\baselineskip}
   \sdju@signpair{\hspace{2\ccwd}\sdju@date}{\sdju@date}
  \end{sdju@declbody}
  % ---- 版权使用授权书 ----
  \clearpage
  \sdju@decltitle{毕业设计（论文）版权使用授权书}%
  \begin{sdju@declbody}
   本毕业设计（论文）作者同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权上海电机学院可以将本毕业设计（论文）的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本毕业设计（论文）。\par
   \sdjuspacing{1.5}%
   \hspace*{2\ccwd}\begin{tabular}{@{}l@{\hspace{1\ccwd}}l@{}}
     \multirow{2}{*}{本论文属于} & \textbf{保密}□，在\underline{\hspace{2\ccwd}}年解密后适用本授权书。\\
                                & \textbf{不保密}□。
   \end{tabular}\par
   \hspace*{2\ccwd}（请在以上方框内打“√”）\par
   \sdjuspacing{2}%
   \vspace{2\baselineskip}
   \sdju@signpair{作者签名：}{指导教师签名：}
   \vspace{0.5\baselineskip}
   \sdju@signpair{\sdju@date}{\sdju@date}
  \end{sdju@declbody}
  \clearpage
  \fi}

% ===============================================================
% 摘要
%   中文：标题小二号黑体居中；正文小四号宋体，首行缩进 2 字符，段前段后 12 磅，1.25 倍行距；
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
  {\sdjuchapter{摘\hspace{1em}要}\setlength{\parskip}{12bp}}
  {\sdju@kwline{{\heiti\sdjufont{10.5bp}{19.5bp}关键词：}}{\sdju@keywords}%
   \setlength{\parskip}{0pt}}
\newenvironment{abstracten}
  {\sdjuchapter[][31.2bp]{\rmfamily\bfseries ABSTRACT}\setlength{\parskip}{12bp}}
  {\sdju@kwline{{\rmfamily\bfseries\sdjufont{10.5bp}{19.5bp}Key words: }}{\sdju@keywordsen}%
   \setlength{\parskip}{0pt}}

% ===============================================================
% 致谢：标题小二号黑体居中；正文五号宋体，首行缩进 2 字符，单倍行距
% ===============================================================
\newenvironment{acknowledgements}
  {\sdjuchapter[致谢]{致\hspace{1em}谢}\sdjufont{10.5bp}{\sdju@grid}}
  {\par}

\RequirePackage[hidelinks,bookmarksnumbered,unicode]{hyperref}
\graphicspath{{figures/}}
\endinput
