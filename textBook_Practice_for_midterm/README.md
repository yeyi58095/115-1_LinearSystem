# Linear System — Textbook Practice for Midterm

主檔：`textbook_midterm_practice.tex`。109 題組，英文題目與 Solution 作答區，未提供解答，保留使用者已寫內容。姓名：葉彥辰；學號：P46154345。

第 **1–30 題**為第一輪題型巡迴：各主要題型先選一題，依估計手算量與整合程度由淺入深安排，不按章節排列；涵蓋基底、線性映射、行列式、子空間、伴隨矩陣、特徵多項式、Cayley–Hamilton、遞迴、轉移函數、線性方程、值域／零空間、複數特徵結構、相似關係、週期解、建模、線性化、平衡點、座標轉換、SISO／MIMO 實現、對角化、矩陣指數／函數、矩陣多項式、CT／DT 模態、脈衝響應。教材已足夠，不需另從作業補題。

第 **31–109 題**是第二輪：剩餘 79 題隨機混排，包含較長與綜合題；第二輪不再依難度排序。主檔前附第一輪題型索引。計算量只是相對估計，證明題難度視熟悉程度而異。排序已固定。

## 來源與推估範圍

來源為專案根目錄的 `../linearsys_note.pdf`（實際檔名含 linear）。教師尚未公告範圍，依 HW1–HW5 的原始題目判斷，以教材第 2–7 章為主，包含狀態空間建模、平衡與線性化、轉移函數與實現、線性代數、模態、相似變換、Cayley–Hamilton 及矩陣指數；另納入 HW5 已涵蓋的第 9 章 Exercise 108 脈衝響應，第 8 章 Exercise 107 為選做延伸。這不是教師確認的考試範圍。

題號對照見 `SOURCE_MAP.md`。每題標示原題號與印刷頁碼，PDF 實體頁碼為印刷頁碼加 8。原書的重複題保留；Exercise 11/12 編號混排，因此合併為一題組；也收錄 Problem 1 與兩題正文標為 Exercise 的未編號子空間證明。

- 純 MATLAB 數值實驗 Exercise 61 不收錄。Exercise 109 需要 Lyapunov 方程，超出此次推估範圍，不收錄。
- 有手算部分的題目保留；略去 MATLAB 核對、程式、模擬及畫圖。Exercise 70 的模擬小題改為求解析響應；Exercise 56 改為求基底。
- Exercise 59、60、78、90、91、99、108 為數值調整版，盡量保留原本的秩、特徵結構或模態激發類型；具體修改寫在各題編輯註。
- 原書 Exercise 48 第一式缺運算符號，本練習版明定使用加號；Exercise 9、13 的平衡問題明定零輸入；Exercise 85 明定三個向量依序對應特徵值 −2、2j、−2j；Exercise 101 明訂四階矩陣與四個互異特徵值。均已於題中說明，無需等待原書勘誤。
- 參照前例的題目已補列所需模型、矩陣或等式，沒有附上推導。必要模型圖擷取於 `figures/`；原 Figure 3.1 在來源 PDF 為空白，題目保留其完整方程式。

## 作答與編譯

可直接在主檔各題 `Solution` 下方寫答案，並調整 `\vspace{3.5cm}`。不必執行任何產生題目的程式；開始作答後也不需重新洗牌。主檔及 `figures/` 可獨立編譯，不依賴其他作業。此次重新排序保留已有作答：原教材 Exercise 32 隨其解答移至本卷第 105 題。

在 Codex 開啟主檔，即可使用內建 LaTeX 編輯器與編譯診斷。TeXstudio 開啟 `textbook_midterm_practice.tex`，把預設編譯器設為 XeLaTeX，按 **F5** 編譯預覽；總頁碼變動時再編譯一次。

從專案根目錄執行 PowerShell：

```powershell
Set-Location -LiteralPath 'textBook_Practice_for_midterm'
$texFile = 'textbook_midterm_practice.tex'
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build $texFile
if ($LASTEXITCODE -ne 0) { throw '第一次編譯失敗' }
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build $texFile
if ($LASTEXITCODE -ne 0) { throw '第二次編譯失敗' }
```

命令列輸出：`build/textbook_midterm_practice.pdf`。TeXstudio 若未設定輸出目錄，PDF 會在主檔旁：`textbook_midterm_practice.pdf`。中文字型為 Microsoft JhengHei。
