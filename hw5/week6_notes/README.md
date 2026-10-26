# Week 6 課堂筆記

- 課程來源：`../linearsys_w6_note.pdf`，原 PDF 共 48 頁。筆記各節標示對應頁次。
- 可編輯主檔：`lecture/main.tex`。這是獨立的補課文件，不取代 Homework 5 主檔。
- PDF：`lecture/build/main.pdf`。
- 內容：前置線性代數、矩陣多項式、Cayley–Hamilton、minimal polynomial、矩陣指數、取樣、Jordan form、卷積、脈衝、輸入輸出與頻率響應，附自編練習及解析。
- 教學補充與自編例已在文件中標明，並非老師逐字講稿。
- 字型：Microsoft JhengHei；UTF-8；XeLaTeX。

在此資料夾執行：

```powershell
Set-Location -LiteralPath 'lecture'
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build main.tex
if ($LASTEXITCODE -ne 0) { throw '第一次編譯失敗' }
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build main.tex
if ($LASTEXITCODE -ne 0) { throw '第二次編譯失敗' }
```

TeXstudio：開啟 `lecture/main.tex`，將預設編譯器設為 XeLaTeX，再按 F5 編譯預覽。未設定輸出目錄時，PDF 可能位於 `lecture/main.pdf`；以上命令的 PDF 則在 `lecture/build/main.pdf`。

本次已嘗試開啟 Codex 內建 LaTeX 編輯器；內建編譯診斷回報 Windows sandbox 不支援，故改用已安裝的 XeLaTeX 編譯兩次，並將 PDF 渲染核對。`tmp/` 為來源與成品的視覺核對縮圖。
