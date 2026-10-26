# Homework 5

- 題目來源：`linearsys_hw5.pdf`（共 2 頁、7 題）
- LaTeX 主檔：`linearSystem_hw5.tex`（已修正先前 linearSsytem 的拼字）
- 排版沿用 hw4：Solution 靠左、子題不縮排，解答區維持留白。
- 截止日期照題目原文保留為 Friday, Oct 31。
- 編譯方式：在此資料夾以 XeLaTeX 編譯兩次；命令列輸出至 `build/` 時，PDF 為 `build/linearSystem_hw5.pdf`。TeXstudio 若未設定輸出目錄，PDF 會產生在主檔旁。
- TeXstudio：開啟 `linearSystem_hw5.tex`，按 F5 編譯並預覽。

```powershell
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build linearSystem_hw5.tex
if ($LASTEXITCODE -ne 0) { throw '第一次編譯失敗' }
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build linearSystem_hw5.tex
if ($LASTEXITCODE -ne 0) { throw '第二次編譯失敗' }
```
