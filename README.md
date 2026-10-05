# Linear System

線性系統課程作業，使用 XeLaTeX 撰寫。

| 作業目錄 | LaTeX 主檔 |
| --- | --- |
| `hw1/` | `main.tex` |
| `hw2/` | `main.tex` |
| `hw3/` | `linearSsytem_hw3.tex` |

各作業目錄包含題目 PDF、原始碼與個別 README；`hw1/` 另含 MATLAB 程式與所需圖片。共用作業指引見 `AGENTS.md`。

## 編譯

需安裝 XeLaTeX 與 Microsoft JhengHei（微軟正黑體）。可在 TeXstudio 開啟各作業主檔，選擇 XeLaTeX，按 F5 編譯預覽。

PowerShell 範例（從專案根目錄執行）：

```powershell
Set-Location -LiteralPath hw3
$texFile = 'linearSsytem_hw3.tex'
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build $texFile
if ($LASTEXITCODE -ne 0) { throw '第一次編譯失敗' }
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build $texFile
if ($LASTEXITCODE -ne 0) { throw '第二次編譯失敗' }
```

此範例輸出為 `hw3/build/linearSsytem_hw3.pdf`；TeXstudio 未指定輸出目錄時，PDF 通常位於主檔旁。

Git 忽略編譯產物與 `tmp/` 預覽檔，保留原始題目 PDF、參考資料及編譯所需圖片。
