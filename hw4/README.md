# Linear System — Homework 4

- 題目來源：`linearsys_hw4.pdf`，共 3 頁、8 題；截止日為 Friday, Oct 23。
- LaTeX 主檔：`linearSsytem_hw4.tex`。保留既有解答；第 7(b)、8 題附 MATLAB 圖表、實際模擬初值，文末附完整程式碼原文。未代寫手算推導與文字分析。
- 題目 PDF 已更新為老師更正版：第 7 題運動方程分別使用兩個擺長 l1、l2；主檔題目與 E1 推導已同步更正。參數組 P1–P4 沿用 hw1，與既有模擬一致。

## MATLAB 執行與工作區

不需要另外建立 MATLAB Project。在 MATLAB 將 Current Folder 設為本資料夾，開啟 `hw4_ex7_ex8.m` 後按 Run，或輸入：

```matlab
hw4_ex7_ex8(7) % 只重新產生第 7 題；不修改第 8 題輸出。
% hw4_ex7_ex8 % 同時產生第 7、8 題。
```

- 主程式：`hw4_ex7_ex8.m`；同資料夾的模型函式：`cart_pendulum_model.m`。
- 會產生 9 組模擬、27 張獨立圖表，存於 `figures/`（PNG 與可編輯的 FIG）；每張比較同一變數的線性與非線性結果。
- `hw4_workspace.mat` 儲存參數 `P`、8 組模型 `models`、供自行核對的 `eigenvalues`、各組資料 `results` 與求解器設定。工作區可用 `load('hw4_workspace.mat')` 還原；本檔沒有把第 7(a) 的書面答案填入作業。
- `results(k)` 包含 `t`、`A`、`xe`、`z0`、`x0`、`zLinear`、`xNonlinear`、`zNonlinear` 等資料。`z=x-xe` 為偏差狀態；E2 的實際角度須加回 π。
- 第 7(b) 依確認使用相反方向角度偏移，L7 為 0、1、10、90、180 deg，L8 為 1 deg；初始小車位置與速度均為零。
- 第 8(a) 選振盪模態；(b)、(c) 分別選負／正實特徵值模態。角度初值縮放至最大絕對值 1 deg；書面選取理由仍留白。衰減模態以純模態指數式計算，避免浮點誤差混入不穩定模態。
- 圖表一律畫偏差，角度顯示為度數，不做 ±180° 折返。L7 的 180° 是精確設定，不自行加擾動。
- `simulation-*.tex` 由 MATLAB 產生並由主檔引用；已產生的圖表保留後即可獨立編譯，不需每次重跑 MATLAB。
- 問老師的疑點及目前設定整理於 `questions-for-professor.md`。

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

本次已用本機 XeLaTeX 直接在此資料夾編譯兩次，最新完整 PDF 為主檔旁的 `linearSsytem_hw4.pdf`（26 頁）；未更新 build 內的同名 PDF。Codex 內建編譯器目前無法載入本文件的外部 `simulation-*.tex` 引用，故請以本機完整 PDF 為準。

## TeXstudio

開啟本資料夾的 `linearSsytem_hw4.tex`，確認預設編譯器為 XeLaTeX，按 F5 編譯並預覽。若未設定輸出目錄，PDF 會產生於主檔旁的 `linearSsytem_hw4.pdf`，而非 `build/linearSsytem_hw4.pdf`。

第 7(b) 題依 L7 的 0、±1、±10、±90、±180 度及 L8 的 ±1 度分組，每組先呈現三張獨立比較圖，再附對應程式碼；尚未撰寫比較分析段落。± 表示兩擺分別為 -alpha、+alpha，其餘初始偏移與初速為零。
