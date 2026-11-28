\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjumproposal}[2026/11/28 v1.0 SDJU Master proposal]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax
\LoadClass[a4paper,UTF8,fontset=none,scheme=chinese,zihao=-4,oneside]{ctexart}
\RequirePackage[top=2.54cm,bottom=2.54cm,left=3.175cm,right=3.175cm]{geometry}
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

\RequirePackage{array,longtable,multirow,amssymb}
\newcommand\sdju@needspace[1]{%
  \par\ifinner\else\ifdim\pagegoal<\maxdimen
    \ifdim\dimexpr\pagegoal-\pagetotal\relax<#1\relax\newpage\fi
  \fi\fi}
\setlength\LTpre{0pt}
\setlength\LTpost{0pt}
\newcolumntype{C}[1]{>{\centering\arraybackslash}m{#1}}
\NewDocumentCommand\FormHeading{m}{%
  \sdju@needspace{3\baselineskip}\par\medskip\noindent
  {\heiti\sdjufont{14}{21}#1\par}\smallskip}
\NewDocumentCommand\RowHeight{m}{\rule[-.22\dimexpr#1\relax]{0pt}{#1}}
\NewDocumentCommand\VerticalLabel{m}{%
  \shortstack{#1}}
\NewDocumentCommand\FormCheckBox{}{\ensuremath{\square}}

% 将可分页正文拆成带边框的片段。末尾签字可用 minipage 保持同页。
\newbox\sdju@body
\newbox\sdju@piece
\newdimen\sdju@available
\newdimen\sdju@labelcolumn
\newdimen\sdju@pieceheight
\newdimen\sdju@padding
\sdju@padding=6bp
\newcommand\sdju@getavailable{%
  \ifdim\pagegoal=\maxdimen \sdju@available=\textheight
  \else \sdju@available=\dimexpr\pagegoal-\pagetotal\relax\fi
  \advance\sdju@available by -\dimexpr2\sdju@padding+2\arrayrulewidth+\topskip\relax}
\newcommand\sdju@framepiece{%
  \nointerlineskip
  \sdju@pieceheight=\dimexpr\ht\sdju@piece+\dp\sdju@piece+2\sdju@padding\relax
  \hbox{\vrule\vbox{\hrule
    \kern\sdju@padding
    \hbox{%
      \ifdim\sdju@labelcolumn>0pt
        \vbox to\sdju@pieceheight{\vfil
          \hbox to\sdju@labelcolumn{\hfil\VerticalLabel{\sdju@verticallabel}\hfil}\vfil}%
        \vrule width\arrayrulewidth
      \fi
      \vbox{\kern\sdju@padding
        \hbox{\kern\sdju@padding\box\sdju@piece\kern\sdju@padding}%
        \kern\sdju@padding}}%
    \hrule}\vrule}%
  \par\nointerlineskip\kern-\arrayrulewidth}
\NewDocumentEnvironment{formbox}{m O{} O{}}{%
  \par\sdju@needspace{\dimexpr\baselineskip*4\relax}%
  \def\sdju@minimum{#1}\def\sdju@continuation{#2}%
  \def\sdju@verticallabel{#3}%
  \ifx\sdju@verticallabel\@empty\sdju@labelcolumn=0pt
  \else\sdju@labelcolumn=11mm\fi
  \setbox\sdju@body=\vbox\bgroup
    \hsize=\dimexpr\linewidth-2\sdju@padding-2\arrayrulewidth\relax
    \ifdim\sdju@labelcolumn>0pt
      \advance\hsize by -\dimexpr\sdju@labelcolumn+\arrayrulewidth\relax
    \fi
    \linewidth=\hsize\columnwidth=\hsize
}{%
  \par\egroup
  \sdju@getavailable
  \ifdim\sdju@minimum>\sdju@available
    \ifdim\sdju@minimum<.96\textheight
      \newpage\sdju@getavailable
    \fi
  \fi
  \ifdim\dimexpr\ht\sdju@body+\dp\sdju@body\relax<\sdju@minimum
    \setbox\sdju@body=\vbox to\sdju@minimum{\unvbox\sdju@body\vfil}%
  \fi
  \splittopskip=\topskip\splitmaxdepth=\maxdepth\vbadness=10000
  \loop\ifdim\dimexpr\ht\sdju@body+\dp\sdju@body\relax>\sdju@available
    \setbox\sdju@piece=\vsplit\sdju@body to\sdju@available
    \sdju@framepiece
    \ifvoid\sdju@body\else
      \newpage
      \ifx\sdju@continuation\@empty\else\FormHeading{\sdju@continuation{}（续）}\fi
      \sdju@getavailable
    \fi
  \repeat
  \ifvoid\sdju@body\else
    \setbox\sdju@piece=\box\sdju@body
    \sdju@framepiece
  \fi
}
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
% 校名图样取自本模板的 Word 原件。
\NewDocumentCommand\CoverLogo{}{%
  \par\centering\includegraphics[width=299bp]{sdju-wordmark.jpg}\par}
\NewDocumentCommand\CoverTitle{m}{%
  {\heiti\sdjufont{\sdju@coversize}{32}\TitleText{#1}}\par}
\NewDocumentCommand\CoverField{mm}{\rule{0pt}{\sdju@fieldheight}#1 & #2\\\cline{2-2}}

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
\newcommand\sdju@researchdirection{}
\newcommand\researchdirection[1]{\renewcommand\sdju@researchdirection{#1}}
\newcommand\sdju@degreefield{}
\newcommand\degreefield[1]{\renewcommand\sdju@degreefield{#1}}
\newcommand\sdju@companysupervisorunit{}
\newcommand\companysupervisorunit[1]{\renewcommand\sdju@companysupervisorunit{#1}}
\newcommand\sdju@thesisperiod{}
\newcommand\thesisperiod[1]{\renewcommand\sdju@thesisperiod{#1}}
\newcommand\sdju@proposaldatesrc{}
\newcommand\proposaldate[1]{\renewcommand\sdju@proposaldatesrc{#1}}
\newcommand\sdju@proposaldate{%
  \ifx\sdju@proposaldatesrc\@empty 年\hspace{1em}月\hspace{1em}日\else\sdju@proposaldatesrc\fi}

\newcommand\sdju@covertitle{\TitleText{\@title}}
\newcommand\sdju@companymentor{%
  \sdju@companysupervisor
  \ifx\sdju@companysupervisorunit\@empty\else
    \ifx\sdju@companysupervisor\@empty\else，\fi
    \sdju@companysupervisorunit
  \fi}

\newcommand\makecover{%
  \begin{titlepage}
  \centering
  \vspace*{\dimexpr13mm-12bp\relax}
  \CoverLogo
  \vspace{1mm}
  \CoverTitle{硕士研究生学位论文开题报告}
  \vspace{29mm}
  \begin{coverfields}
  \CoverField{论 文 题 目}{\sdju@covertitle}
  \CoverField{类别（领域）}{\sdju@degreefield}
  \CoverField{研 究 方 向}{\sdju@researchdirection}
  \CoverField{校 内 导 师}{\sdju@supervisor}
  \CoverField{企业导师及单位}{\sdju@companymentor}
  \CoverField{学\qquad 号}{\sdju@studentid}
  \CoverField{姓\qquad 名}{\@author}
  \CoverField{学\qquad 院}{\sdju@school}
  \CoverField{论文起止年限}{\sdju@thesisperiod}
  \CoverField{申请开题日期}{\sdju@proposaldate}
  \end{coverfields}
  \vfill
  {\sdjufont{15}{21}上海电机学院研究生处\par}
  \vspace{8mm}
  \end{titlepage}}

\NewDocumentEnvironment{coverfields}{}{%
  \par\centering\sdjufont{\sdju@fieldsize}{19}%
  \begin{tabular}{@{}p{\sdju@labelwidth} >{\centering\arraybackslash}m{\sdju@fieldwidth}@{}}%
}{\end{tabular}\par}
\newcommand\sdju@coversize{26}
\newcommand\sdju@fieldsize{15}
\newcommand\sdju@labelwidth{44mm}
\newcommand\sdju@fieldwidth{80mm}
\newcommand\sdju@fieldheight{25bp}
\AtBeginDocument{\sdjufont{12}{19.5}\pagestyle{empty}}
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
      \ClassWarningNoLine{sdjumproposal}{配置文件声明了签名角色 #1，但找不到 \sdju@signdir#1.png，该处留空}#3}%
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

% 原件从开题正文开始编号，意见表及评议表单独归档。
\setlength\footskip{11bp}
\newcommand\ps@proposalbody{%
  \let\@oddhead\@empty\let\@evenhead\@empty
  \def\@oddfoot{\hfil\normalfont\sdjufont{9}{11.7}\thepage\hfil}%
  \let\@evenfoot\@oddfoot}
