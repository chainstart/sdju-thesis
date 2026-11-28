\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjumthesis}[2026/11/28 v1.0 SDJU Professional master thesis]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\LoadClass[a4paper,UTF8,fontset=none,scheme=chinese,zihao=-4,oneside,openany]{ctexbook}
\RequirePackage[top=3.5cm,bottom=4cm,left=2.8cm,right=2.8cm]{geometry}
\RequirePackage{graphicx}

% 逐个检测字体，部分安装时仍能正确回退。
\IfFontExistsTF{SimSun}{%
  \setCJKmainfont[AutoFakeBold=2.5]{SimSun}%
  \setCJKfamilyfont{zhsong}[AutoFakeBold=2.5]{SimSun}%
}{\setCJKmainfont[BoldFont=FandolSong-Bold.otf]{FandolSong-Regular.otf}%
  \setCJKfamilyfont{zhsong}[BoldFont=FandolSong-Bold.otf]{FandolSong-Regular.otf}}
\IfFontExistsTF{SimHei}{\setCJKfamilyfont{zhhei}[AutoFakeBold=2.5]{SimHei}}%
  {\setCJKfamilyfont{zhhei}[BoldFont=FandolHei-Bold.otf]{FandolHei-Regular.otf}}
\IfFontExistsTF{KaiTi}{\setCJKfamilyfont{zhkai}[AutoFakeBold=2.5]{KaiTi}}%
  {\setCJKfamilyfont{zhkai}[AutoFakeBold=2.5]{FandolKai-Regular.otf}}
\IfFontExistsTF{FangSong}{\setCJKfamilyfont{zhfs}{FangSong}}%
  {\setCJKfamilyfont{zhfs}{FandolFang-Regular.otf}}
\IfFontExistsTF{Times New Roman}{\setmainfont{Times New Roman}}%
  {\setmainfont{TeX Gyre Termes}}
\IfFontExistsTF{Arial}{\setsansfont{Arial}}{\setsansfont{TeX Gyre Heros}}
\providecommand\songti{\CJKfamily{zhsong}}
\providecommand\heiti{\CJKfamily{zhhei}}
\providecommand\kaishu{\CJKfamily{zhkai}}
\providecommand\fangsong{\CJKfamily{zhfs}}
\NewDocumentCommand\sdjufont{mm}{\linespread{1}\fontsize{#1bp}{#2bp}\selectfont}
\ctexset{autoindent=2}
\setlength\parskip{0pt}
\raggedbottom
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

% 采用本科开题报告的中文词界规则，允许用手工换行覆盖。
\NewDocumentCommand\TitleText{m}{%
  \begingroup\centering
  \sdju@wordsplit{#1}{\linewidth}{\linewidth}%
  \sdju@ifws{%
    \setbox\z@\hbox{#1}%
    \ifdim\wd\z@>\linewidth \sdju@wsA\\\sdju@wsB\else #1\fi
  }{#1}\par\endgroup}
\RequirePackage[backend=biber,style=gb7714-2005,gbnamefmt=lowercase,
  gbpub=false,gbtype=true,url=true]{biblatex}
\RequirePackage[hidelinks,unicode]{hyperref}
\newcommand\sdju@signrole[1]{\global\@namedef{sdju@sigon@#1}{}}
\newcommand\sdju@signdate[4]{\global\@namedef{sdju@sdate@#1}{{#2}{#3}{#4}}}
\newcommand\sdju@signdir{signatures/}
% \sdju@ifsign{角色}{有签名时}{没有时}
\newcommand\sdju@ifsign[3]{%
  \ifcsname sdju@sigon@#1\endcsname
    \IfFileExists{\sdju@signdir#1.png}{#2}{%
      \ClassWarningNoLine{sdjumthesis}{配置文件声明了签名角色 #1，但找不到 \sdju@signdir#1.png，该处留空}#3}%
  \else #3\fi}
\newbox\sdju@sigbox
% 签名图片（零尺寸，参考点在签字处左端的签字线上）：#1 角色，#2 签字处宽度，#3 签名高度；
%   图片在签字处中水平居中
\newcommand\sdju@sign[3]{\sdju@ifsign{#1}{%
  \setbox\sdju@sigbox\hbox{\includegraphics[height=#3,width=#2,keepaspectratio]{\sdju@signdir#1.png}}%
  \smash{\rlap{\kern\dimexpr(#2-\wd\sdju@sigbox)/2\relax\box\sdju@sigbox}}}{}}
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

% 角色由原件的签字位置决定，空线可供手签。
\NewDocumentCommand\Signature{O{26mm}m}{%
  \leavevmode\raisebox{-.8bp}[0pt][0pt]{\sdju@sign{#2}{#1}{20bp}}%
  \rule[-1bp]{#1}{.4bp}}
\NewDocumentCommand\SignatureDate{m}{%
  \leavevmode\hbox to8.3em{\sdju@datefill{#1}{2.5em}{1.4em}{1.4em}\hss}}
\InputIfFileExists{sdju-signatures.cfg}{}{}

% 页眉和页脚分别按距纸顶 2.5 cm、距纸底 3 cm 的位置设置。
\RequirePackage{fancyhdr}
\setlength\headheight{13bp}
\setlength\headsep{1cm}
\setlength\footskip{\dimexpr 1cm-3.6bp\relax}
\fancypagestyle{sdjuthesis}{%
  \fancyhf{}%
  \fancyhead[C]{\songti\sdjufont{9}{11.7}上海电机学院硕士学位论文}%
  \fancyfoot[C]{\sdjufont{9}{11.7}\sdju@folio}%
  \renewcommand\headrule{\hrule height1.5bp\vskip1bp\hrule height.75bp\vskip-3.25bp}%
  \renewcommand\footrulewidth{0pt}}
\newcommand\sdju@folio{\thepage}
\newcommand\sdju@numberedpages{\pagestyle{sdjuthesis}\let\ps@plain\ps@sdjuthesis}
\AddToHook{cmd/frontmatter/after}{\renewcommand\thepage{\Roman{page}}\renewcommand\sdju@folio{\thepage}\sdju@numberedpages}
\AddToHook{cmd/mainmatter/after}{\renewcommand\sdju@folio{-\,\thepage\,-}\sdju@numberedpages}

% 四号 14 bp，小四号 12 bp，五号 10.5 bp。单倍行框 1.3，正文再乘 1.25。
\AtBeginDocument{\songti\sdjufont{12}{19.5}\pagestyle{empty}}
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}
\ctexset{
  chapter={name={第,章},number=\arabic{chapter},aftername=\quad,
    format=\centering\heiti\bfseries\sdjufont{16}{20.8},
    beforeskip=19.85bp,afterskip=19.85bp,fixskip=true,pagestyle=plain},
  section={format=\heiti\bfseries\sdjufont{14}{18.2},
    aftername=\quad,beforeskip=13bp,afterskip=13bp,afterindent=true},
  subsection={format=\heiti\bfseries\sdjufont{12}{15.6},
    aftername=\quad,beforeskip=13bp,afterskip=13bp,afterindent=true},
  appendix={name={附录,},number=\arabic{chapter}}
}
\RequirePackage{titletoc}
\titlecontents{chapter}[0pt]{\heiti\bfseries\sdjufont{12}{19.5}}%
  {第\thecontentslabel 章\quad}{}{\titlerule*[.5em]{.}\contentspage}
\titlecontents{section}[12bp]{\songti\sdjufont{12}{19.5}}%
  {\contentslabel{2.4em}}{}{\titlerule*[.5em]{.}\contentspage}
\titlecontents{subsection}[24bp]{\songti\sdjufont{12}{19.5}}%
  {\contentslabel{3em}}{}{\titlerule*[.5em]{.}\contentspage}

\NewDocumentCommand\CoverHeading{m}{%
  {\songti\sdjufont{18}{23.4}\TitleText{#1}}}
\NewDocumentCommand\CoverChineseTitle{m}{%
  {\kaishu\bfseries\sdjufont{26}{33.8}\TitleText{#1}}}
\NewDocumentCommand\CoverEnglishTitle{m}{%
  {\songti\sdjufont{22}{28.6}\TitleText{#1}}}
\NewDocumentEnvironment{coverfields}{}{%
  \par\centering\sdjufont{14}{18.2}%
  \begin{tabular}{@{}l p{.53\linewidth}@{}}%
}{\end{tabular}\par}
\NewDocumentCommand\CoverField{mm}{%
  \rule[-5bp]{0pt}{25bp}{\heiti\bfseries#1} & #2\\}

% 导言区基本信息命令。
\author{}
\newcommand\sdju@studentid{}
\newcommand\studentid[1]{\renewcommand\sdju@studentid{#1}}
\newcommand\sdju@school{}
\newcommand\school[1]{\renewcommand\sdju@school{#1}}
\newcommand\sdju@supervisor{}
\newcommand\supervisor[1]{\renewcommand\sdju@supervisor{#1}}
\newcommand\sdju@companysupervisor{}
\newcommand\companysupervisor[1]{\renewcommand\sdju@companysupervisor{#1}}
\title{}
\newcommand\sdju@englishtitle{}
\newcommand\englishtitle[1]{\renewcommand\sdju@englishtitle{#1}}
\newcommand\sdju@degreename{}
\newcommand\degreename[1]{\renewcommand\sdju@degreename{#1}}
\newcommand\sdju@supervisortitle{}
\newcommand\supervisortitle[1]{\renewcommand\sdju@supervisortitle{#1}}
\newcommand\sdju@companysupervisortitle{}
\newcommand\companysupervisortitle[1]{\renewcommand\sdju@companysupervisortitle{#1}}
\newcommand\sdju@defensedatesrc{}
\newcommand\defensedate[1]{\renewcommand\sdju@defensedatesrc{#1}}
\newcommand\sdju@defensedate{%
  \ifx\sdju@defensedatesrc\@empty 年\hspace{1em}月\hspace{1em}日\else\sdju@defensedatesrc\fi}
\newcommand\sdju@classificationnumber{}
\newcommand\classificationnumber[1]{\renewcommand\sdju@classificationnumber{#1}}
\newcommand\sdju@confidentiality{}
\newcommand\confidentiality[1]{\renewcommand\sdju@confidentiality{#1}}
\newcommand\sdju@udc{}
\newcommand\udc[1]{\renewcommand\sdju@udc{#1}}
\newcommand\sdju@thesisnumber{}
\newcommand\thesisnumber[1]{\renewcommand\sdju@thesisnumber{#1}}

\newcommand\sdju@internalmentor{%
  \sdju@supervisor\ifx\sdju@supervisortitle\@empty\else（\sdju@supervisortitle）\fi}
\newcommand\sdju@externalmentor{%
  \sdju@companysupervisor\ifx\sdju@companysupervisortitle\@empty\else（\sdju@companysupervisortitle）\fi}
% 同一个档案字段可写为「类别（领域）」或只写类别。
\ExplSyntaxOn
\tl_new:N \sdju@degreecategory
\tl_new:N \sdju@degreearea
\seq_new:N \l__sdju_degree_parts_seq
\NewDocumentCommand\degreefield{m}
  {
    \regex_extract_once:nnNTF { \A (.*?) [（(] (.*?) [）)] \s* \Z } {#1}
      \l__sdju_degree_parts_seq
      {
        \tl_set:Nx \sdju@degreecategory { \seq_item:Nn \l__sdju_degree_parts_seq {2} }
        \tl_set:Nx \sdju@degreearea { \seq_item:Nn \l__sdju_degree_parts_seq {3} }
        \tl_trim_spaces:N \sdju@degreecategory
        \tl_trim_spaces:N \sdju@degreearea
      }
      { \tl_set:Nn \sdju@degreecategory {#1} \tl_clear:N \sdju@degreearea }
  }
\ExplSyntaxOff
\newcommand\ThesisTitle{\@title}
\newcommand\ThesisEnglishTitle{\sdju@englishtitle}

\newcommand\makecover[1]{%
  \begin{titlepage}
  \centering
  \sdjufont{12}{19.5}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll@{}}
  分类号：\sdju@classificationnumber & 密级：\sdju@confidentiality\\
  UDC：\sdju@udc & 编号：\sdju@thesisnumber
  \end{tabular*}\par
  \vspace{11mm}
  \CoverHeading{上海电机学院专业硕士学位论文}
  \vspace{14mm}
  \CoverChineseTitle{\@title}
  \vspace{7mm}
  \CoverEnglishTitle{\sdju@englishtitle}
  \vfill
  \begin{coverfields}
  \CoverField{硕士研究生：}{\@author}
  \CoverField{学\qquad 号：}{\sdju@studentid}
  \CoverField{校内导师：}{\sdju@internalmentor}
  \CoverField{企业导师：}{\sdju@externalmentor}
  \CoverField{类\qquad 别：}{\sdju@degreecategory}
  \CoverField{领\qquad 域：}{\sdju@degreearea}
  \CoverField{申请学位：}{\sdju@degreename}
  \CoverField{所在单位：}{\sdju@school}
  \CoverField{答辩日期：}{\sdju@defensedate}
  \CoverField{授予学位单位：}{#1}
  \end{coverfields}
  \vspace{6mm}
  \end{titlepage}}

\NewDocumentEnvironment{declaration}{m}{%
  \clearpage\thispagestyle{empty}%
  \vspace*{19.85bp}%
  {\centering\heiti\bfseries\sdjufont{18}{35.1}上海电机学院\\#1\par}%
  \vspace{22bp}\songti\sdjufont{14}{27.3}%
}{\par\clearpage}
\NewDocumentEnvironment{thesisabstract}{m m}{%
  \clearpage\phantomsection\addcontentsline{toc}{chapter}{#2}%
  \vspace*{19.85bp}%
  {\heiti\bfseries\sdjufont{16}{20.8}\TitleText{#1}}%
  \vspace{19.85bp}%
  {\centering\heiti\bfseries\sdjufont{16}{20.8}#2\par}%
  \vspace{22.75bp}\songti\sdjufont{14}{22.75}%
}{\par\clearpage}
\NewDocumentCommand\ChineseKeywords{m}{%
  \par\vspace{22.75bp}\noindent{\heiti\bfseries 关键词：}#1\par}
\NewDocumentCommand\EnglishKeywords{m}{%
  \par\vspace{45.5bp}\noindent\textbf{KEY WORDS:} #1\par}

\newcommand\sdju@plainheading[1]{%
  \vspace*{19.85bp}%
  {\centering\heiti\bfseries\sdjufont{16}{20.8}#1\par}%
  \vspace{39bp}}
\RenewDocumentCommand\tableofcontents{}{%
  \clearpage\sdju@plainheading{目\quad 录}\@starttoc{toc}}
\NewDocumentCommand\ThesisEndChapter{m}{%
  \clearpage\phantomsection\addcontentsline{toc}{chapter}{#1}%
  \sdju@plainheading{#1}}
\renewcommand\bibfont{\songti\sdjufont{12}{19.5}}
\setlength\bibitemsep{0pt}
\setlength\bibparsep{0pt}

% 表题在上，图题在下。英文行沿用西文字体，两种语言共用一个编号。
\RequirePackage{array,booktabs,longtable,caption,subcaption,amsmath,amssymb}
\DeclareCaptionFont{sdjucaption}{\kaishu\sdjufont{10.5}{13.65}}
\captionsetup{font=sdjucaption,labelsep=space,justification=centering,
  singlelinecheck=false}
\captionsetup[figure]{position=bottom,skip=6bp,belowskip=13.65bp}
\captionsetup[table]{position=top,skip=6.825bp}
\captionsetup[subfigure]{font=sdjucaption,labelformat=simple,labelsep=space}
\renewcommand\thesubfigure{\alph{subfigure})}
\NewDocumentCommand\FigureCaption{m m}{%
  \caption[#1]{#1\protect\\\normalfont Fig.\thefigure\ #2}}
\NewDocumentCommand\TableCaption{m o}{%
  \IfNoValueTF{#2}{\caption{#1}}%
    {\caption[#1]{#1\protect\\\normalfont Table \thetable\ #2}}}
\newcommand\FormCheckBox{\ensuremath{\square}}
\newcommand\ThesisTableFont{\songti\sdjufont{10.5}{13.65}}
\setlength\heavyrulewidth{1.5bp}
\setlength\lightrulewidth{.5bp}
\renewcommand\thefigure{\thechapter-\arabic{figure}}
\renewcommand\thetable{\thechapter-\arabic{table}}
\renewcommand\theequation{\thechapter-\arabic{equation}}
\DeclareMathSizes{12bp}{12bp}{8bp}{6bp}
\def\tagform@#1{\maketag@@@{\sdjufont{12}{15.6}（\ignorespaces#1\unskip\@@italiccorr）}}

% 附录仍逐个开始新页，当中的图表公式使用独立编号。
\NewDocumentCommand\ThesisAppendix{m}{%
  \clearpage\refstepcounter{chapter}%
  \addcontentsline{toc}{chapter}{附录\arabic{chapter}}%
  \sdju@plainheading{附录\arabic{chapter}}%
  \noindent #1\par}
\AddToHook{cmd/appendix/after}{%
  \renewcommand\thefigure{附\arabic{chapter}-\arabic{figure}}%
  \renewcommand\thetable{附\arabic{chapter}-\arabic{table}}%
  \renewcommand\theequation{附\arabic{chapter}-\arabic{equation}}}
