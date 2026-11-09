# 上海电机学院毕业设计（论文）LaTeX 模板

上海电机学院本科毕业设计的两套 LaTeX 模板：**学士学位论文**和**开题报告**，依据学校下发的 Word 模板制作。

| 目录 | 内容 | 依据 |
|---|---|---|
| [`thesis/`](thesis/) | 学士学位论文模板及示例 | 附件15《学士学位论文封面》、附件17《毕业设计（论文）格式规范》、《论文格式-无红色标注.pdf》 |
| [`proposal/`](proposal/) | 开题报告模板及示例 | 附件13《毕业设计（论文）开题报告》 |
| [`word-templates/`](word-templates/) | 学校下发的 Word 原始模板 | — |

两个模板目录各自独立，复制其中一个目录就可以开始写。示例的排版效果见 [`thesis/main.pdf`](thesis/main.pdf) 和 [`proposal/proposal.pdf`](proposal/proposal.pdf)。

## 文件

**`thesis/`——学士学位论文**

| 文件 | 说明 |
|---|---|
| `sdjuthesis.cls` | 论文模板类，格式参数都在这里 |
| `sdjubase.sty` | 公共设定：字体、字号与行距、Word 行框换算、图表题与表格、断行、参考文献样式 |
| `main.tex` | 论文主文件：论文信息、各部分顺序 |
| `chapters/` | 摘要、各章、致谢（示例文字取自学校样本） |
| `refs.bib` | 参考文献库（含样本中 10 类文献示例） |
| `figures/` | 图片；`sdju-logo.jpg` 为封面校徽 |
| `latexmkrc` | latexmk 配置（XeLaTeX + Biber） |
| `main.pdf` | 示例的编译结果 |

写论文时只需改 `main.tex` 和 `chapters/`。

**`proposal/`——开题报告**

| 文件 | 说明 |
|---|---|
| `sdjuproposal.cls` | 开题报告模板类 |
| `sdjubase.sty` | 公共设定，与 `thesis/` 下的那份内容相同 |
| `proposal.tex` | 开题报告示例（文字取自学校模板） |
| `refs-proposal.bib` | 示例的参考文献库 |
| `latexmkrc` | latexmk 配置 |
| `proposal.pdf` | 示例的编译结果 |

**`word-templates/`——学校的 Word 原始模板**

| 文件 | 说明 |
|---|---|
| `附件13 毕业设计（论文）开题报告.doc` | 开题报告模板 |
| `附件15 学士学位论文封面.docx` | 论文封面 |
| `附件17 毕业设计（论文）格式规范.doc`、`.pdf` | 论文格式规范，红色批注为格式要求 |
| `论文格式-无红色标注.pdf` | 去掉批注后的论文样本，本模板核对版面时以它为准 |

## 编译

```bash
cd thesis   && latexmk main.tex       # 论文：xelatex -> biber -> xelatex -> xelatex
cd proposal && latexmk proposal.tex   # 开题报告
latexmk -c                            # 清理中间文件
```

需要 TeX Live 2020 及以上（含 ctex、biblatex-gb7714-2015、biber）。

## 字体

规范要求宋体、黑体、Times New Roman，封面用微软雅黑。模板自动检测：有 Windows 字体就用，没有则用 TeX Live 自带的 Fandol（中文）和 TeX Gyre Termes（西文）代替，版式不变。

在 WSL 中使用 Windows 字体：新建 `~/.config/fontconfig/fonts.conf`

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig><dir>/mnt/c/Windows/Fonts</dir></fontconfig>
```

然后运行 `fc-cache -f`。

## 论文的格式规定（thesis/sdjuthesis.cls）

行距按 Word 的文档网格换算：单倍 = 15.6 磅，1.25 倍 = 19.5 磅，2 倍 = 31.2 磅。

标题、目录等处的间距按 Word 的「行框」算法换算（实现见 `sdjubase.sty` 的 `\sdju@pre`、`\sdju@post`）：

- 每行占一个行框，行框高即行距；四号、小二号字高于一格网格，单倍行距时占两格（31.2 磅）。
- 文字在行框内上下居中，段前、段后加在行框之外。
- 相邻两段的段后与段前取较大者，不叠加（如一级标题后紧跟二级标题、二级标题后紧跟三级标题）。

因此下表各处只需给出「字号、行框高、段前、段后」，改格式时改这几个参数即可。

| 部分 | 格式 |
|---|---|
| 页面 | A4；上 2.8 cm，下、左、右 2.5 cm；页眉 2 cm |
| 页眉 | 左：论文题目，黑体小五号；右：页码，小五号；下有 0.75 磅横线；无页脚 |
| 页码 | 封面无；声明、摘要、目录 I, II, …；正文起 1, 2, … |
| 声明页 | 全页 2 倍行距（31.2 磅）：空两行，标题两行（「上海电机学院」+ 声明名称）小二号黑体加粗居中，空一行，正文四号宋体、首行缩进 2 字符；签名前空三行（AI 使用情况声明内容多，空一行），签名与日期之间空一行 |
| 摘要 | 标题小二号黑体居中；正文小四号宋体，首行缩进 2 字符，1.25 倍行距，段前段后 12 磅（与标题的段后 12 磅不叠加）；「关键词：」五号黑体，关键词小四号 |
| ABSTRACT | 标题小二号 Times New Roman 加粗居中，段前 31.2 磅；正文同上；「Key words:」五号加粗 |
| 目录 | 标题小二号黑体加粗居中，段前 31.2 磅、段后 12 磅；一级标题黑体四号（行框 31.2 磅），二级标题黑体小四号（行框 15.6 磅）并缩进 2 字符，均为单倍行距；引导线为短横线；页码统一五号 |
| 一级标题 | 小二号黑体加粗居中，行框 31.2 磅，段前 0、段后 12 磅，每章另起页，编号「1 绪论」；摘要、参考文献、致谢等标题同此格式 |
| 二级标题 | 四号宋体，首行缩进 2 字符，行框 31.2 磅，段前 12、段后 0 磅，编号「1.1」 |
| 三级标题 | 小四号黑体，首行缩进 2 字符，行框 15.6 磅，段前 12、段后 0 磅，编号「1.1.1」 |
| 正文 | 小四号宋体 / Times New Roman，首行缩进 2 字符，1.25 倍行距 |
| 断行 | 与 Word 一致，英文单词不用连字符拆开；网址、长标识符可在 `/ . - _` 等符号处换行 |
| 分项 | (1)、(2)、(3)…，与正文同样缩进 |
| 公式 | 另起一行居中，按章编号「（2-1）」，编号右对齐 |
| 表 | 三线表，线粗 0.5 磅；表名在表正上方，宋体小五号加粗「表2-1 …」；表内文字小四号、单倍行距（列多时可用 `\sdjutablesize` 改小）；一页放得下的表用 `table` + `tabular`，跨页的长表用 `longtable`，续页右上方「续表2-1」并重复表头 |
| 图 | 图名在图正下方，宋体小五号加粗「图2-1 …」 |
| 参考文献 | GB/T 7714-2005 顺序编码制（与样本一致）；正文中 `\cite` 为上标「[1]」；条目小四号，悬挂缩进 2 字符，1.25 倍行距；可由 `.bib` 生成，也可在 `references` 环境中手工录入 |
| 致谢 | 标题小二号黑体居中；正文五号宋体，首行缩进 2 字符，单倍行距 |

## 常用命令

```latex
\title[页眉短题目]{封面题目，可用 \\ 换行}
\author{} \studentid{} \school{} \major{} \supervisor{} \coverdate{二〇二七年五月}

\makecover                 % 封面
\frontmatter \makedeclaration
\keywords{甲，乙，丙}  \begin{abstract} ... \end{abstract}
\keywordsen{A, B, C}   \begin{abstracten} ... \end{abstracten}
\sdjutableofcontents
\mainmatter  \chapter{} \section{} \subsection{}
\backmatter  \sdjubibliography
\begin{acknowledgements} ... \end{acknowledgements}

\cite{key}          % 上标引用 [1]
\parencite{key}     % 非上标 [1]
\sdjucontinued{4}   % longtable 续页表头中的「续表x-x」（参数为列数）
\sdjutablesize{10.5bp}  % 其后表格的表内文字改用五号（放在花括号里只对一个表有效）
\sdjuspacing{1.5}   % 按 Word 的倍数设置当前行距
```

### 手工录入参考文献

没有 `.bib` 文献库（例如从 Word 稿转过来）时，用 `references` 环境代替 `\sdjubibliography`，标题与条目格式相同，条目自动编号：

```latex
正文中引用\sdjucite{1}，或多篇\sdjucite{2-4}。   % 上标 [1]、[2-4]

\begin{references}
  \item 蒋有绪, 郭泉水, 马娟, 等. 中国森林群落分类及其群落学特征[M]. 北京: 科学出版社, 1998: 11-12.
  \item\label{ref:ahn} Ahn H, Kim K J, Han I, et al. Hybrid genetic algorithms …[J]. Expert Systems, 2010, 23(3): 127-144.
\end{references}
```

条目加了 `\label` 后，可写 `\sdjucite{\ref{ref:ahn}}`，调整条目顺序时编号自动跟着变。

### 表格注意事项

- `longtable` 不是浮动体。它和 `[t]`、`[htbp]` 的图表落在同一页时，版心可能被撑破（内容超出下边距）。所以一页放得下的表一律用 `table` + `tabular`；确实要跨页的长表才用 `longtable`，必要时在它前面加 `\clearpage`。
- 列数多的表在小四号下排不开时，用 `{\sdjutablesize{10.5bp} \begin{table} … \end{table}}` 把这一个表改成五号。

## 开题报告（proposal/sdjuproposal.cls）

依据《附件13 毕业设计（论文）开题报告》，字体、字号、行距、参考文献著录的设定与论文模板相同，都在 `sdjubase.sty` 中。

| 部分 | 格式 |
|---|---|
| 页面 | A4；上 2.54 cm，下 2 cm，左、右 2.5 cm；页脚距纸边 1.25 cm，页码在页脚右侧（小五号），封面无页码 |
| 封面 | 边框内自上而下逐行排，均为 1.5 倍行距：段前 18 磅，校名与「毕业设计（论文）开题报告」一号华文中宋加粗；空两行；各栏目小二号宋体加粗，内容（小三号）写在下划线上；空两行；定稿日期小三号加粗。课题名称占两行下划线，一行写不下时自动转到第二行（两行约 34 个汉字，再长则自动缩小字号，也可用 `\\` 手工分行） |
| 课题名称 | 小一号宋体加粗居中；副标题以「——」开头右对齐 |
| 摘要、关键词 | 「摘要：」「关键词：」小四号加粗，内容小四号宋体，首行缩进 2 字符 |
| 一级标题 | 四号宋体加粗，左对齐，行框 31.2 磅，段前段后 13 磅（「1 文献综述」） |
| 二级标题 | 小四号宋体，首行缩进 2 字符（「3.1 …」） |
| 正文 | 小四号宋体 / Times New Roman，首行缩进 2 字符，1.25 倍行距 |
| 进度安排 | `schedule` 环境，内容换行后与首行内容对齐 |
| 参考文献 | 另起一页，「参考文献：」小二号黑体加粗居中；条目小四号单倍行距，悬挂缩进 2 字符；同样可用 `references` 环境手工录入 |
| 意见页 | `\supervisoropinion{...}` 指导教师意见、`\committeeopinion` 答辩小组意见与结论，各占一页 |

```latex
\title{课题名称} \subtitle{副标题} \school{} \major{} \classname{} \studentid{} \author{} \supervisor{}
\finaldate{2027 年 1 月 10 日}  \keywords{甲，乙，丙}
\makecover  \maketitle  \begin{abstract} ... \end{abstract}
\section{文献综述} ...  \begin{schedule} \item{时间段}{工作内容} \end{schedule}
\sdjubibliography  \supervisoropinion{}  \committeeopinion
```

## 与学校样本（WPS 输出）的已知差异

模板按统一参数排版，不逐像素模仿 WPS。下列差异属于排版引擎不同或样本本身的不一致：

- **折行位置**：TeX 按整段优化断行，WPS 逐行排满并会压缩标点，个别行末的字会落在不同行。
- **声明页页码**：样本三页声明都标「I」（是 Word 分节造成的），模板按顺序编为 I、II、III。
- **目录**：样本目录是手工输入的（含正文中没有的「1.4 本章小结」）；模板根据正文标题自动生成。
- **章编号**：样本正文中「结论」为第 5 章（中间章节省略），目录里却写「3 结论」；模板按实际顺序自动编号。
- **参考文献**：由 GB/T 7714-2005 样式生成，与样本手工文字略有出入（如「北京: 」后有空格，英文作者缩写不加点）。
- **空白与位置**：样本中原红色批注处留有空白，图表位置随之不同；模板中的图表按浮动体自动放置。
- **声明页**：样本三页声明的标题高低不一（相差约 7～14 磅），模板统一为「空两行」；签名栏的左右位置按半页宽对齐，不照搬样本里用空格凑出的位置。
- **表格**：三线表的线与文字之间用 booktabs 的默认间距，比样本略松；样本表格撑满版心，模板按内容宽度居中。
- **页眉页码**：样本的页码右侧留了约 3 个字符的空，模板的页码贴齐右边距。
- **开题报告**：学校只提供了 Word 文件，没有 PDF 样本；封面与正文按 Word 文件中的格式参数排版。封面的华文中宋字体需自行安装（没有时用宋体代替）。

## 维护说明

- `sdjubase.sty` 在 `thesis/` 和 `proposal/` 下各有一份，为的是两个目录都能单独复制使用。**两份的内容必须相同**，修改时要同时改，可用 `diff thesis/sdjubase.sty proposal/sdjubase.sty` 检查。
- 模板按统一的格式参数排版，不逐像素模仿 Word 的输出；与样本的差异见上一节。
