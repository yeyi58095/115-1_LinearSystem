# Linear System — Homework 1

`main.tex` 是作業主檔，解答目前留白。支援中文、英文與數學公式，使用 XeLaTeX 編譯。

## 使用 TeXstudio（已安裝）

1. 用 TeXstudio 開啟本資料夾的 `main.tex`。
2. 填入姓名、學號，在 `Exercise 1` 下開始寫解答。
3. 主檔第一行 `% !TeX program = xelatex` 已指定 XeLaTeX。
4. 按 **F5（Build & View）** 編譯並預覽。
5. 如果編輯器沒有採用主檔設定，到「Options → Configure TeXstudio → Build → Default Compiler」選擇 **XeLaTeX**。

TeXstudio 預設產生的 PDF 為主檔旁的 `main.pdf`。本專案已載入 `xeCJK`，請保持使用 XeLaTeX。

新增題目可使用 `\section*{Exercise 2}`。

## 使用 VS Code（可選）

1. 用 VS Code 開啟整個 `Week1` 資料夾。
2. 安裝推薦擴充套件 **LaTeX Workshop** (`james-yu.latex-workshop`)。
3. 編輯 `main.tex`，填入姓名、學號及解答。
4. 儲存後會自動編譯，也可從命令面板執行 `LaTeX Workshop: Build LaTeX project`。
5. 從命令面板執行 `LaTeX Workshop: View LaTeX PDF file` 預覽。

產生的 PDF 位於 `build/main.pdf`。新增題目可使用 `\section*{Exercise 2}`。

## 使用 PowerShell 編譯

在本資料夾執行：

```powershell
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build main.tex
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build main.tex
```

兩次編譯用於更新交叉引用與頁碼。原始題目保留在 `linearsys_hw1.pdf`。
