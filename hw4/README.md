# Linear System — Homework 4

- 題目來源：`linearsys_hw4.pdf`，共 3 頁、8 題；截止日為 Friday, Oct 23。
- LaTeX 主檔：`linearSsytem_hw4.tex`。沿用先前作業格式，已填姓名、學號，所有 Solution 保留空白。
- 原題僅引用參數組 P1–P4，未列出其數值；本檔忠實保留原題，未自行補入參數。

## XeLaTeX 編譯

在本資料夾執行：

```powershell
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build linearSsytem_hw4.tex
if ($LASTEXITCODE -ne 0) { throw '第一次編譯失敗' }
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build linearSsytem_hw4.tex
if ($LASTEXITCODE -ne 0) { throw '第二次編譯失敗' }
```

輸出為 `build/linearSsytem_hw4.pdf`。頁碼改變後需編譯兩次。

## TeXstudio

開啟本資料夾的 `linearSsytem_hw4.tex`，確認預設編譯器為 XeLaTeX，按 F5 編譯並預覽。若未設定輸出目錄，PDF 會產生於主檔旁的 `linearSsytem_hw4.pdf`，而非 `build/linearSsytem_hw4.pdf`。
