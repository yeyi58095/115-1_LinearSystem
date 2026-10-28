# Linear System — Midterm Practice

24 題原創改編模擬考，共 100 分；建議作答 240 分鐘，可分兩次練習。英文題目、空白解題區，不含答案。主檔為 `main.tex`，可獨立編譯，不依賴其他作業檔案。

## 出題依據

已閱讀原始題目 `../hw1/linearsys_hw1.pdf` 至 `../hw5/linearsys_hw5.pdf`；以下為主題對照，而非逐字轉錄。這是依現有作業設計的練習範圍，並非教師確認的期中考範圍。

| 題號 | 主題 | 參考作業 |
|---|---|---|
| 1–3 | 連續／離散狀態空間建模 | HW1、HW2 |
| 4–6 | 平衡點、可微性、含輸入輸出的線性化 | HW2 |
| 7–10 | 轉移矩陣、延遲、伴隨形式、最小實現 | HW2、HW3 |
| 11 | 狀態座標轉換與轉移函數不變性（延伸整合） | HW2、HW3 的狀態空間與實現主題 |
| 12–14 | 一致性、零空間、值域、線性獨立 | HW3 |
| 15–17 | 特徵結構、伴隨矩陣、秩一矩陣 | HW3、HW4 |
| 18–20 | 連續／離散模態與初始條件 | HW4 |
| 21–24 | Cayley–Hamilton、矩陣指數、脈衝響應、週期解證明 | HW5 |

1–20 題各 4 分，21–24 題各 5 分。每頁兩題，共 13 頁（含說明頁）；需要較長推導時可另加紙張。

## XeLaTeX 編譯

從專案根目錄執行：

```powershell
Set-Location -LiteralPath 'midtermPractice'
$texFile = 'main.tex'
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build $texFile
if ($LASTEXITCODE -ne 0) { throw '第一次編譯失敗' }
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build $texFile
if ($LASTEXITCODE -ne 0) { throw '第二次編譯失敗' }
```

輸出：`build/main.pdf`。中文使用 Microsoft JhengHei。

## 開啟與作答

- Codex：開啟此資料夾，使用內建 LaTeX 編輯器與 PDF 預覽。
- TeXstudio：開啟 `main.tex`，將預設編譯器設為 XeLaTeX，按 F5 編譯預覽；頁碼變動後再編譯一次。若未指定輸出目錄，PDF 位於主檔旁的 `main.pdf`，與命令列輸出的 `build/main.pdf` 不同。
- 在每題的 `Solution` 區域自行作答，可視需求移除或縮小 `\vspace{3cm}`。
