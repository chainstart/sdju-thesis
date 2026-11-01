# 上海电机学院学士学位论文 LaTeX 模板

依据学校的《附件15 学士学位论文封面》《附件17 毕业设计（论文）格式规范》和《论文格式-无红色标注.pdf》制作。
格式参数全部集中在 `sdjuthesis.cls`，写论文时只需改 `main.tex` 和 `chapters/`。

## 文件

| 文件 | 说明 |
|---|---|
| `sdjuthesis.cls` | 模板类文件（所有格式） |
| `main.tex` | 主文件：论文信息、各部分顺序 |
| `chapters/` | 摘要、各章、致谢（示例文字取自学校样本） |
| `refs.bib` | 参考文献库（含样本中 10 类文献示例） |
| `figures/` | 图片；`sdju-logo.jpg` 为封面校徽 |
| `latexmkrc` | latexmk 配置（XeLaTeX + Biber） |

## 编译

```bash
latexmk        # xelatex -> biber -> xelatex -> xelatex
latexmk -c     # 清理中间文件
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

## 格式规定（统一参数）

行距按 Word 的文档网格换算：单倍 = 15.6 磅，1.25 倍 = 19.5 磅，2 倍 = 31.2 磅。

| 部分 | 格式 |
|---|---|
| 页面 | A4；上 2.8 cm，下、左、右 2.5 cm；页眉 2 cm |
| 页眉 | 左：论文题目，黑体小五号；右：页码，小五号；下有 0.75 磅横线；无页脚 |
| 页码 | 封面无；声明、摘要、目录 I, II, …；正文起 1, 2, … |
| 声明页 | 标题小二号黑体加粗居中（「上海电机学院」+ 声明名称）；正文四号宋体，首行缩进 2 字符，2 倍行距 |
| 摘要 | 标题小二号黑体居中；正文小四号宋体，首行缩进 2 字符，1.25 倍行距，段前段后 12 磅；「关键词：」五号黑体，关键词小四号 |
| ABSTRACT | 标题小二号 Times New Roman 加粗居中；正文同上；「Key words:」五号加粗 |
| 目录 | 标题小二号黑体居中，段后 12 磅；一级标题黑体四号，二级标题黑体小四号并缩进 2 字符；页码统一五号 |
| 一级标题 | 小二号黑体居中，段前 0、段后 12 磅，每章另起页，编号「1 绪论」 |
| 二级标题 | 四号宋体，首行缩进 2 字符，段前 12、段后 0 磅，编号「1.1」 |
| 三级标题 | 小四号黑体，首行缩进 2 字符，段前 12、段后 0 磅，编号「1.1.1」 |
| 正文 | 小四号宋体 / Times New Roman，首行缩进 2 字符，1.25 倍行距 |
| 分项 | (1)、(2)、(3)…，与正文同样缩进 |
| 公式 | 另起一行居中，按章编号「（2-1）」，编号右对齐 |
| 表 | 三线表；表名在表正上方，宋体小五号加粗「表2-1 …」；跨页用 `longtable`，续页右上方「续表2-1」并重复表头 |
| 图 | 图名在图正下方，宋体小五号加粗「图2-1 …」 |
| 参考文献 | GB/T 7714-2005 顺序编码制（与样本一致）；正文中 `\cite` 为上标「[1]」；条目小四号，悬挂缩进 2 字符，1.25 倍行距 |
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
\sdjuspacing{1.5}   % 按 Word 的倍数设置当前行距
```

## 与学校样本（WPS 输出）的已知差异

模板按统一参数排版，不逐像素模仿 WPS。下列差异属于排版引擎不同或样本本身的不一致：

- **折行位置**：TeX 按整段优化断行，WPS 逐行排满并会压缩标点，个别行末的字会落在不同行。
- **声明页页码**：样本三页声明都标「I」（是 Word 分节造成的），模板按顺序编为 I、II、III。
- **目录**：样本目录是手工输入的（引导线为连字符，含正文中没有的「1.4 本章小结」）；模板自动生成，引导线为点线。
- **章编号**：样本正文中「结论」为第 5 章（中间章节省略），目录里却写「3 结论」；模板按实际顺序自动编号。
- **参考文献**：由 GB/T 7714-2005 样式生成，与样本手工文字略有出入（如「北京: 」后有空格，英文作者缩写不加点）。
- **空白与位置**：样本中原红色批注处留有空白，图表位置随之不同；模板中的图表按浮动体自动放置。
