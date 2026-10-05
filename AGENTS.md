# Linear System — 專案共用作業指引

## 目標與溝通
- 使用繁體中文與使用者溝通；題目保留原文語言。
- 使用者要自己寫作業。當使用者要求「開始」、「準備作業」或「初始化」時，先建立含完整題目與空白解題區的 LaTeX 文件，不自動解題。
- 使用者之後指定題目、要求提示、解題或檢查時，再依當次要求協助。

## 適用範圍與作業辨識
- `LinearSystem/` 是專案根目錄；本檔統一適用於所有作業子目錄，例如 `hw1/`、`hw2/`、`hw3/`。共用規則集中維護於此，不在各作業資料夾重複存放 AGENTS.md；只有確有該作業專屬規則時才新增子目錄指引。
- 依使用者指定的作業選擇目標子目錄，將該作業的題目、LaTeX 主檔、README 與編譯輸出放在該子目錄內。不要因目前開啟的是專案根目錄而將各份作業混放在根目錄。
- 週次可從 WeekN 或 hwN 等資料夾名稱輔助辨識，但週次不一定等於 Homework 編號。
- 題目來源優先採用使用者指定的檔案，其次依目標作業子目錄中的原始作業 PDF（例如 linearsys_hwN.pdf）及其內容判斷。不要把自行產生的解答 PDF（例如 main.pdf、linearSsytem_hw3.pdf）或 build/ 內的 PDF 當成原始題目。
- 作業編號以使用者明確指定或題目文件標示為準，檔名與資料夾名稱僅作輔助。若有多份候選題目、編號衝突或無法確認，先釐清；可先完成不依賴該資訊的骨架，不自行猜選或合併。
- 標題使用 Linear System --- Homework N，將 N 換成已確認的作業編號；尚未確認時先用 Linear System --- Homework，並標註待確認。
- 主檔名稱優先遵照使用者指定並保留拼法；既有作業沿用原主檔，不自行重新命名。新作業未指定檔名時可使用 main.tex。目前 hw1 與 hw2 使用 main.tex，hw3 使用 linearSsytem_hw3.tex。

## 初次準備流程
1. 先檢查目標作業子目錄的目前檔案，確認主檔；若主檔已存在，保留使用者已寫內容，只補缺少部分，不重新覆蓋整份文件，也不另外建立重複主檔。
2. 依上述規則確認本次作業的題目來源。讀取所有頁面，確認題數、子題、公式、矩陣與圖形；必要時渲染 PDF 核對。不可沿用其他週次的題目或答案。
3. 在目標作業子目錄建立已確認檔名的 LaTeX 主檔：標題依已確認的作業編號設定，姓名為葉彥辰、學號為 P46154345。每題使用 \section*{Exercise N}，忠實轉錄題目；保留原始子題編號及條件，不省略題目、不自行改寫數學假設。
4. 在每題或需要分開作答的子題後建立 \subsection*{Solution} 或 \textbf{Solution}，只放註解「% 在這裡撰寫解答。」與適量空白（例如 \vspace{3cm}）。不要填推導、答案、提示或範例解答。空白高度可依版面調整，不強制每題一頁。
5. 題目含必要圖形時，保留或擷取為目標作業子目錄內的圖檔並引用。無法辨識的內容要明確標示並請使用者釐清，不得猜測。若題目來源缺失，先建立可編譯骨架並告知缺少來源，不捏造題目。
6. 在目標作業子目錄建立簡短 README.md，說明題目來源、實際主檔名稱、XeLaTeX 編譯方式，以及如何在 TeXstudio 開啟主檔並以 F5 編譯預覽。
7. 在 Codex 中建立或編輯獨立 LaTeX 文件時，預設開啟內建 LaTeX 編輯器並使用其編譯診斷工具；若工具或環境不支援，保留原始碼並明確說明限制。需要輸出 PDF 時，可使用已安裝的 XeLaTeX 編譯兩次，檢查編譯錯誤、缺字與超出版面問題，並查看產生的 PDF，確認題目齊全、公式正確且解題區留白。回報實際主檔與 PDF 路徑；未成功的編譯不得宣稱成功。

## 各週共用排版約定
- UTF-8；檔案開頭放 `% !TeX program = xelatex` 與 `% !TeX encoding = UTF-8`。
- `\documentclass[12pt,a4paper]{article}`；geometry 邊界 2.5cm。
- 使用 amsmath、amssymb、amsthm、xeCJK、graphicx、hyperref（hidelinks）、fancyhdr。
- 中文字型為 `\setCJKmainfont{Microsoft JhengHei}`。若環境沒有此字型，再找可用中文字型並告知替代結果。
- 使用 `\date{}`，頁尾置中顯示「目前頁碼/總頁數」，標題頁也相同。
- 可用下列設定取得總頁數，頁數變動後編譯兩次：

```tex
\makeatletter
\newcommand{\totalpages}{\@abspage@last}
\makeatother
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[C]{\thepage/\totalpages}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[C]{\thepage/\totalpages}%
}
```

- 本指引已包含必要排版設定，不需要其他週次的檔案。若使用者指定既有作業作為排版參考，只參考格式；每份作業必須能在自己的子目錄內獨立編譯，不依賴其他週次檔案，也不要複製其題目、解答或模擬內容。
- 不因初始化作業而新增模擬、程式或額外報告。

## PowerShell 編譯
先進入目標作業子目錄，再執行以下指令。範例以 hw3 為例，其他作業須換成實際主檔名稱：

```powershell
Set-Location -LiteralPath 'hw3' # 從 LinearSystem 專案根目錄執行；已在 hw3 時略過。
$texFile = 'linearSsytem_hw3.tex'
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build $texFile
if ($LASTEXITCODE -ne 0) { throw '第一次編譯失敗' }
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build $texFile
if ($LASTEXITCODE -ne 0) { throw '第二次編譯失敗' }
```

每次編譯都檢查結束碼；輸出為該作業的 build/<主檔檔名>.pdf（例如 hw3/build/linearSsytem_hw3.pdf）。TeXstudio 若未指定輸出目錄，PDF 可能產生於主檔旁，README 應區分兩種路徑。

## 後續編輯
- 保留題目來源 PDF 與使用者解答；修改以使用者要求的範圍為主。
- 檢查答案時，先指出有問題的步驟及理由；只有使用者要求修改時才直接改寫其解答。
