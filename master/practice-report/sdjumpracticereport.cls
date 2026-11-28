\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdjumpracticereport}[2026/11/28 v1.0 SDJU Professional practice report]
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

\RequirePackage{array}
\NewDocumentCommand\FormHeading{m}{%
  \par\medskip\noindent
  {\heiti\sdjufont{14}{21}#1\par}\smallskip}

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
  \par\centering\includegraphics[width=299.4bp]{sdju-wordmark.jpg}\par}
\NewDocumentCommand\CoverTitle{m}{%
  {\heiti\sdjufont{\sdju@coversize}{32}\TitleText{#1}}\par}
\NewDocumentCommand\CoverField{mm}{\rule{0pt}{\sdju@fieldheight}#1 & #2\\\cline{2-2}}
\NewDocumentEnvironment{coverfields}{}{%
  \par\centering\sdjufont{\sdju@fieldsize}{19}%
  \begin{tabular}{@{}p{\sdju@labelwidth} >{\centering\arraybackslash}m{\sdju@fieldwidth}@{}}%
}{\end{tabular}\par}
\newcommand\sdju@coversize{26}
\newcommand\sdju@fieldsize{14}
\newcommand\sdju@labelwidth{35mm}
\newcommand\sdju@fieldwidth{81mm}
\newcommand\sdju@fieldheight{35bp}
\AtBeginDocument{\sdjufont{12}{19.5}\pagestyle{empty}}

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
\newcommand\sdju@researchdirection{}
\newcommand\researchdirection[1]{\renewcommand\sdju@researchdirection{#1}}
\newcommand\sdju@degreefield{}
\newcommand\degreefield[1]{\renewcommand\sdju@degreefield{#1}}
\newcommand\sdju@practiceunit{}
\newcommand\practiceunit[1]{\renewcommand\sdju@practiceunit{#1}}
\newcommand\sdju@practicestart{}
\newcommand\practicestart[1]{\renewcommand\sdju@practicestart{#1}}
\newcommand\sdju@practiceend{}
\newcommand\practiceend[1]{\renewcommand\sdju@practiceend{#1}}

% 封面实践时间沿用原件的年月范围，网站写入的日期含日。
\def\sdju@yearmonth#1月#2\@nil{#1月}
\newcommand\sdju@monthordateblank[1]{%
  \ifx#1\@empty 年\hspace{1em}月%
  \else\expandafter\sdju@yearmonth#1月\@nil\fi}
\newcommand\sdju@practiceperiod{%
  \sdju@monthordateblank\sdju@practicestart 至\sdju@monthordateblank\sdju@practiceend}

\newcommand\makecover{%
  \begin{titlepage}
  \centering
  \vspace*{\dimexpr7mm-12bp\relax}
  \CoverLogo
  \vspace{10mm}
  \CoverTitle{赴\sdju@practiceunit\\专业实践总结报告}
  \vspace{11mm}
  \begin{coverfields}
  \CoverField{姓\quad 名}{\@author}
  \CoverField{学\quad 号}{\sdju@studentid}
  \CoverField{校内导师}{\sdju@supervisor}
  \CoverField{企业导师}{\sdju@companysupervisor}
  \CoverField{研究方向}{\sdju@researchdirection}
  \CoverField{类别（领域）}{\sdju@degreefield}
  \CoverField{学\quad 院}{\sdju@school}
  \CoverField{实践时间}{\sdju@practiceperiod}
  \end{coverfields}
  \end{titlepage}}

\RequirePackage[hidelinks,unicode]{hyperref}
