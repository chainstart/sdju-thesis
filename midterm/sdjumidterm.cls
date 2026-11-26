%% sdjumidterm.cls
%% 上海电机学院 毕业设计（论文）中期检查报告 LaTeX 模板
%% 依据：《教学归档材料及质量评价要素（2026 版）》附件24《毕业设计（论文）中期检查报告》
%%
%% 行距约定：Word 中文字体单倍行距 = 1.3 × 字号（小四号 15.6bp），文字在行框内上下居中。
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
% 栏目名中的半角符号「(」「)」「/」：样表为宋体的半角字形（半个字宽），有宋体时照用；
%   没有宋体时用 Fandol 宋体的西文字形，放在半个字宽的盒子里居中，占位与宋体相同
%   （用户 2026-11-26 决定：这一处与字体无关的排版改进在回退版中同样启用）
\ifsdju@realfonts
  \newfontfamily\sdju@songlatin{SimSun}
  \newcommand\sdju@asc[1]{{\sdju@songlatin#1}}
\else
  \newfontfamily\sdju@songlatin{FandolSong-Regular.otf}
  \newcommand\sdju@asc[1]{\makebox[.5em]{\sdju@songlatin#1}}
\fi

% ===============================================================
% 格式参数（字号单位 bp，即 Word 中的「磅」）
% ===============================================================
\newcommand\sdjufont[2]{\fontsize{#1}{#2}\selectfont}
\def\sdju@grid{15.6bp}                       % 小四号单倍行距
% Word 中中文字体的单倍行距 = 1.3 × 字号（附件14 的文档网格为 15.6 磅，小四号单倍行距正好一格）；
% 「x 倍行距」= x × 单倍行距。文字在行框内上下居中：行框高 L、字号 s 时，基线在行框顶之下
% (L - s)/2 + 0.86s（\sdju@ascent）。表格不留上下内边距（附件14 的单元格上下边距为 0）。
\def\sdju@single{1.3}
% 表格内填写的内容（附件14 各格的段落格式，2026 版附件24 未另作规定）：小四号、单倍行距、两端对齐；
%   中期报告一栏为仿宋（\sdju@bodyfont），指导教师意见、答辩小组建议为宋体（\sdju@opinionfont）；
%   不设首行缩进（附件14 各格段落没有缩进；样表没写明的按模板原样，不另加惯例）。
\newcommand\sdju@bodyindent{0pt}
\newcommand\sdju@bodyfont{\fangsong}
\newcommand\sdju@opinionfont{\songti}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{15.6bp}%
  \abovedisplayskip 6bp plus 3bp minus 3bp
  \abovedisplayshortskip 0bp plus 3bp
  \belowdisplayshortskip 6bp plus 3bp minus 3bp
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize
\setlength{\parindent}{\sdju@bodyindent}
\setlength{\parskip}{0pt}
% 页面顶端的第一行（标题、续页的表格边线）从版心顶算起，不加 \topskip
\setlength{\topskip}{0pt}
\AtBeginDocument{\setlength{\topskip}{0pt}}
% 当前字号、行距下 Word 行框中基线距行框顶的距离，及一个高为当前行距的行框支柱
\newcommand\sdju@ascent{\dimexpr(\baselineskip-1em)/2+0.86em\relax}
\newcommand\sdju@wstrut{\vrule height\sdju@ascent depth\dimexpr\baselineskip-\sdju@ascent\relax width\z@}
% 格子中正文第一行：基线在格子上边线之下一个 \sdju@ascent（在竖直模式的开头使用）
\newcommand\sdju@firstline{\prevdepth=\dimexpr\baselineskip-\sdju@ascent\relax}
% 格子中正文最后一行：行框在基线之下还有 \sdju@desc（= 行距 - \sdju@ascent），补足到这个深度，
%   使末行与下边线之间留出 Word 行框的下半部分（附件14 单元格下边距为 0，空白由行距自然留出）
\newcommand\sdju@desc{\dimexpr\baselineskip-\sdju@ascent\relax}
\newcommand\sdju@lastline{\par\ifdim\prevdepth<\sdju@desc\vskip\dimexpr\sdju@desc-\prevdepth\relax\fi}
% Word 固定行距 #1 的一行：基线在行顶之下 0.8 × #1
\newcommand\sdju@exactline[2]{\hbox to\hsize{\vrule height0.8\dimexpr#1\relax depth0.2\dimexpr#1\relax width\z@ #2}}
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
%   表格外缘宽 428.5 磅，左外缘伸出版心左边 6.6 磅（外框线中线伸出 6.1 磅）；左右外框线 1 磅，
%   表格首尾横线 1 磅，其余线 0.5 磅。文字距竖线中线 1.4 磅（附件14 的单元格左右边距），上下边距 0；
%   表格文字小四号宋体，单倍行距。
%   \sdju@row{行高}{单元格…}：一行不可跨页的表格行，行高指相邻两条横线的间距，各单元格内容上下居中；
%     \sdju@cell{宽度}{对齐 l/c/r}{内容}（宽度含其右侧竖线），最后一格用 \sdju@lastcell{对齐}{内容} 占满余下宽度。
%   \sdju@formrow：可跨页的大栏目（中期报告、指导教师意见），内容写不下时在页底断开、下一页接着排；
%     内容少时按「最小高度」留白（取自附件24 各栏的高度），签名栏排在栏目底部。
% ===============================================================
\newlength\sdju@formw      \setlength\sdju@formw{428.5bp}%  表格总宽（外缘）
\newlength\sdju@formshift  \setlength\sdju@formshift{-6.6bp}% 表格左外缘相对版心左边的位移
\newlength\sdju@rule       \setlength\sdju@rule{0.5bp}%     内框线
\newlength\sdju@orule      \setlength\sdju@orule{1bp}%      外框线
\newlength\sdju@labelw     \setlength\sdju@labelw{0pt}%     （本表的大栏目没有竖排栏目名）
\newlength\sdju@padx       \setlength\sdju@padx{0.9bp}%     单元格左右内边距（从外框线内缘算，即距中线 1.4 磅）
\newlength\sdju@pady       \setlength\sdju@pady{0bp}%       单元格上下内边距
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
      \parindent=\z@ \csname sdju@align@#2\endcsname \sdju@wstrut#3\sdju@wstrut\par}$%
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
      \vrule width\z@ height\dimexpr(#1-\sdju@rule)/2+\sdju@axis\relax depth\dimexpr(#1-\sdju@rule)/2-\sdju@axis\relax
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
\let\sdju@curfont\sdju@bodyfont
\newcommand\sdju@bodysetup{%
  \hsize=\sdju@cw \linewidth=\hsize \columnwidth=\hsize \@totalleftmargin=\z@
  \normalfont\normalsize\sdju@curfont\parindent=\sdju@bodyindent \parskip=\z@
  \everypar{}\sdju@firstline}
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
  \addtolength\sdju@minh{-2\sdju@pady-\sdju@rule}% 最小高度指上下两条横线中线的间距
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
  \splittopskip=\sdju@ascent \splitmaxdepth=\maxdimen \vbadness=\@M
  \loop
    \ifdim\sdju@tmpa>\sdju@avail
      \setbox\sdju@piece\vsplit\sdju@body to\dimexpr\sdju@avail-\sdju@desc\relax% 断开处末行留出行框下半部分
      \sdju@outpiece{\sdju@avail}%
      \sdju@firstpiecefalse
      \newpage\sdju@getavail
      \setlength\sdju@tmpa{\ht\sdju@body+\dp\sdju@body}%
  \repeat
  \setbox\sdju@piece\box\sdju@body
  \sdju@outpiece{\sdju@tmpa}%
  \global\setbox\sdju@label\box\voidb@x
  \global\setbox\sdju@tail\box\voidb@x}
% 签名栏：#1 签名人（如「学生签名」），#2「年 月 日」右侧的空白（附件14 段落的右缩进），
%   #3「年 月 日」一行的行框底到栏目下边线的距离。
%   签名一行 1.5 倍行距（23.4 磅），「年 月 日」一行单倍行距，文字在行框内居中，两行基线相距 19.5 磅；
%   签名下划线长 84 磅、线粗 0.6 磅，中线在基线下 1.2 磅，右端距文字区右缘 4.7 磅（附件14、2026 版附件24）。
\newcommand\sdju@signline[2]{\hbox to\hsize{%
  \vrule height\dimexpr(#1-1em)/2+0.86em\relax depth\dimexpr(#1+1em)/2-0.86em\relax width\z@ #2}}
\newcommand\sdju@signature[3]{%
  \global\setbox\sdju@tail\vbox{\hsize=\sdju@cw \parindent=\z@ \offinterlineskip
    \normalfont\songti\sdjufont{12bp}{15.6bp}%
    \sdju@signline{23.4bp}{\hfil#1：\rule[-1.5bp]{84bp}{0.6bp}\kern4.7bp}%
    \sdju@signline{15.6bp}{\hfil 年\hspace{2em}月\hspace{2em}日\hspace{#2}}\kern#3}}

% ===============================================================
% 标题与基本信息表（附件24 第 1 页上部）：\maketitle
%   「上 海 电 机 学 院」三号黑体，字距 0.5 字；「本科生毕业设计（论文）中期检查报告」三号黑体
%   （2026 版附件24 两行都不加粗；旧附件14 第二行加粗，以 2026 版为准）；
%   均居中，固定行距 20 磅（第一行基线在版心顶下 16 磅），段后 7.8 磅
%   基本信息表：行高（相邻横线间距）25.5 磅；前三行四格（栏目名加粗居中，2026 版为宋体加粗），
%   后三行两格（栏目名不加粗、左对齐）；填写的内容不加粗、左对齐（附件14 填写格的段落为 Normal 两端对齐）
% ===============================================================
\renewcommand\maketitle{%
  \par
  \begingroup
  \heiti\sdjufont{16bp}{20bp}\offinterlineskip
  \sdju@exactline{20bp}{\hfil 上\hspace{0.5em}海\hspace{0.5em}电\hspace{0.5em}机\hspace{0.5em}学\hspace{0.5em}院\hfil}%
  \sdju@exactline{20bp}{\hfil 本科生毕业设计（论文）中期检查报告\hfil}%
  \kern 7.8bp
  \endgroup
  \begingroup
  \normalfont\sdjufont{12bp}{15.6bp}%
  \def\sdju@lab##1{{\bfseries##1}}%
  \sdju@thickrule
  \sdju@row{25.5bp}{%
    \sdju@cell{76.05bp}{c}{\sdju@lab{姓\hspace{1em}名}}\sdju@cell{91.2bp}{l}{\sdju@author}%
    \sdju@cell{100.1bp}{c}{\sdju@lab{学\hspace{1em}号}}\sdju@lastcell{l}{\sdju@studentid}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{76.05bp}{c}{\sdju@lab{校内指导教师}}\sdju@cell{91.2bp}{l}{\sdju@supervisor}%
    \sdju@cell{100.1bp}{c}{\sdju@lab{企业指导教师}}\sdju@lastcell{l}{\sdju@companysupervisor}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{76.05bp}{c}{\sdju@lab{专\hspace{1em}业}}\sdju@cell{91.2bp}{l}{\sdju@major}%
    \sdju@cell{100.1bp}{c}{\sdju@lab{学\hspace{1em}院}}\sdju@lastcell{l}{\sdju@school}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{111.05bp}{l}{{\def\CJKecglue{}毕业设计\sdju@asc{(}论文\sdju@asc{)}题目}}\sdju@lastcell{l}{\sdju@title}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{111.05bp}{l}{课题来源\sdju@asc{/}项目编号}\sdju@lastcell{l}{\sdju@projectsource}}%
  \sdju@row{25.5bp}{%
    \sdju@cell{111.05bp}{l}{课题有无变化}%
    \sdju@lastcell{l}{\sdju@checkbox{\sdju@changeno}无\hspace{1em}\sdju@checkbox{\sdju@changeyes}有\hspace{1em}%
      变化原因\ifx\sdju@changereason\@empty\else：\sdju@changereason\fi}}%
  \endgroup}

% ===============================================================
% 正文栏目：\section{中期报告}
%   写在一个通栏的大格里：首行为栏目名及附件24 中的说明
%   「中期报告（已完成的研究内容，所取得阶段性成果，下一步工作计划和研究内容等）」，
%   下面是正文（小四号仿宋，单倍行距，不缩进），栏目底部为「学生签名：____ 年 月 日」，
%   「年 月 日」右侧空 48 磅，其行框底与栏目下边线齐（2026 版附件24 中这一行被栏目下边线压住，
%   模板把它放进栏目内，比样表高 3.7 磅）。
%   栏目写到下一个 \section、\supervisoropinion 或文档结束为止；最小高度 457.3 磅（附件24 的行高），
%   可用可选参数改：\section[120mm]{中期报告}。内容写不下时自动跨页。
%   栏目内的小标题用 \subsection{…}（与正文同字体字号加粗，编号 1、2、3…）。
% ===============================================================
\@namedef{sdju@hint@中期报告}{（已完成的研究内容，所取得阶段性成果，下一步工作计划和研究内容等）}
\@namedef{sdju@minh@中期报告}{457.3bp}
\@namedef{sdju@sign@中期报告}{{学生签名}{48bp}{0bp}}
\newif\ifsdju@rowopen
\newcommand\sdju@rowminh{60mm}
\newcommand\sdju@closerow{%
  \ifsdju@rowopen
    \sdju@lastline\egroup
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
    \expandafter\expandafter\expandafter\sdju@signature\csname sdju@sign@#3\endcsname
  \else \global\setbox\sdju@tail\box\voidb@x \fi
  \setcounter{subsection}{0}%
  \global\sdju@rowopentrue
  \let\sdju@curfont\sdju@bodyfont
  \setbox\sdju@body\vbox\bgroup\sdju@bodysetup
    {\parindent=\z@ \noindent\songti #3\ifcsname sdju@hint@#3\endcsname\csname sdju@hint@#3\endcsname\fi\par}}
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
% 意见页（附件24 第 2 页）
%   \supervisoropinion{<意见内容，可留空>}：另起一页，表格上边线在版心顶；通栏大格，首行「指导教师意见：」，
%     正文小四号宋体、单倍行距；底部「指导教师签名：____ 年 月 日」，「年 月 日」右侧空 36 磅，
%     其行框底距栏目下边线 35.1 磅（2026 版附件24）；最小高度 254.2 磅，内容多时自动加高、跨页。
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
  \sdju@signature{指导教师签名}{36bp}{35.1bp}%
  \let\sdju@curfont\sdju@opinionfont
  \setbox\sdju@body\vbox{\sdju@bodysetup
    {\parindent=\z@ \noindent 指导教师意见：\par}#1\sdju@lastline}%
  \sdju@thickrule
  \sdju@formrow{254.2bp}}
\newlength\sdju@cclabelw \setlength\sdju@cclabelw{33.45bp}% 「答辩小组结论」格宽（含其右侧竖线）
\newcommand\sdju@ccline[1]{\hbox to\hsize{\vrule width\z@ height 21.2bp depth 10bp #1\hfil}}
\newcommand\committeeconclusion[1]{%
  \sdju@closerow
  \par
  \begingroup
  \normalfont\normalsize
  \let\sdju@curfont\sdju@opinionfont
  \setlength\sdju@cw{\sdju@formw-2\sdju@orule-\sdju@cclabelw-2\sdju@padx}%
  % 上部：建议
  \setbox\sdju@body\vbox{\sdju@bodysetup
    {\parindent=\z@ \noindent 建议：\par}#1\sdju@lastline}%
  \setlength\sdju@tmpa{203.9bp-\sdju@rule-2\sdju@pady}%
  \ifdim\dimexpr\ht\sdju@body+\dp\sdju@body\relax>\sdju@tmpa
    \setlength\sdju@tmpa{\ht\sdju@body+\dp\sdju@body}\fi
  % 下部：答辩结论
  \setbox\sdju@tail\vbox{\hsize=\sdju@cw \parindent=\z@ \offinterlineskip
    \kern 6.5bp
    \sdju@ccline{答辩结论：\hspace{1.5em}通过\sdju@checkbox{0}\hspace{5em}不通过\sdju@checkbox{0}}%
    \sdju@ccline{等第评定：\hspace{1.5em}优秀\sdju@checkbox{0}\hspace{1.5em}良好\sdju@checkbox{0}\hspace{1.5em}及格\sdju@checkbox{0}}%
    \sdju@ccline{答辩小组组长签名：}%
    \kern 15.6bp
    \sdju@ccline{答辩小组组员签名：}%
    \sdju@ccline{\hfill 年\hspace{2.5em}月\hspace{2em}日\hspace{4.5em}}%
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
        \def\sdju@s{\vrule height0.86em depth0.14em width\z@}%
        \hbox to\hsize{\sdju@s\hss 答辩\hss}\kern 20.7bp
        \hbox to\hsize{\sdju@s\hss 小组\hss}\kern 20.7bp
        \hbox to\hsize{\sdju@s\hss 结论\hss}\vss}%
      \vrule width\sdju@rule
      \vbox{\hsize=\dimexpr\sdju@cw+2\sdju@padx\relax
        \hbox{\hskip\sdju@padx\vbox to\dimexpr\sdju@tmpa+2\sdju@pady\relax{%
          \hsize=\sdju@cw\vskip\sdju@pady\box\sdju@body\vss}}%
        \hrule height\sdju@rule width\dimexpr\sdju@cw+2\sdju@padx\relax
        \hbox{\hskip\sdju@padx\vbox to\dimexpr207.8bp-\sdju@rule\relax{\hsize=\sdju@cw\box\sdju@tail}}}%
      \hfil\vrule width\sdju@orule}%
    \hrule height\sdju@rule width\sdju@formw}%
  \kern-\sdju@rule\prevdepth=\z@
  \sdju@thickrule
  \endgroup}

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
\endinput
