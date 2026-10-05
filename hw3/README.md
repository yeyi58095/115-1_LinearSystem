# Linear System — Homework 3

- 題目來源：`linearsys_hw3.pdf`，共 3 頁、13 題；Fall 2026，Due: Friday, Oct 16。
- 主檔：`linearSsytem_hw3.tex`（檔名依指定拼法），UTF-8。
- 沿用前次作業的 A4、12pt、2.5cm 邊界、Microsoft JhengHei 中文字型與「目前頁碼／總頁數」頁尾。
- 姓名葉彥辰、學號 P46154345；各題與子題後的 Solution 留白，供自行作答。
- 在 `% 在這裡撰寫解答。` 下加入內容；作答後可縮短或移除該處的 `\vspace`，並視內容長度調整 `\Needspace`。

## TeXstudio

開啟 `linearSsytem_hw3.tex`，使用 XeLaTeX，按 **F5** 建置並預覽。
頁數變動時再編譯一次，使總頁數更新。未設定輸出目錄時，PDF 會產生在主檔旁，名稱為 `linearSsytem_hw3.pdf`。

## PowerShell 編譯

在本資料夾執行：

```powershell
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build linearSsytem_hw3.tex
if ($LASTEXITCODE -ne 0) { throw '第一次編譯失敗' }
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build linearSsytem_hw3.tex
if ($LASTEXITCODE -ne 0) { throw '第二次編譯失敗' }
```

此方式的輸出為 `build/linearSsytem_hw3.pdf`。需有 XeLaTeX、所用套件（含 `needspace`）與 Microsoft JhengHei 字型。
