# Linear System — Homework 2

- 題目來源：`linearsys_hw2.pdf`，共 3 頁、6 題；文件標示 Homework Two，Fall 2026，Due: Friday, Oct 2。
- 主檔：`main.tex`（UTF-8），姓名葉彥辰、學號 P46154345。
- 各題與子題已轉錄，Solution 僅有註解及空白，供自行撰寫。

## 編譯

需安裝 XeLaTeX、所用 LaTeX 套件及 Microsoft JhengHei 字型。在本資料夾以 PowerShell 執行兩次編譯：

```powershell
New-Item -ItemType Directory -Force build | Out-Null
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build main.tex
if ($LASTEXITCODE -ne 0) { throw '第一次編譯失敗' }
xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build main.tex
if ($LASTEXITCODE -ne 0) { throw '第二次編譯失敗' }
```

輸出為 `build/main.pdf`，頁尾顯示目前頁碼／總頁數。

## TeXstudio

開啟 `main.tex`，確認預設編譯器為 XeLaTeX，按 **F5** 建置並預覽。主檔開頭也有 XeLaTeX magic comment。頁數變動時再編譯一次，使總頁數更新。

若 TeXstudio 未設定輸出目錄，輸出會在主檔旁的 `main.pdf`；上述 PowerShell 指令則輸出到 `build/main.pdf`。

## 原題待確認事項

- Exercise 1(c) 的 `simple structure` 與 Exercise 2(c) 的 `first nonlinear system` 僅提供名稱，原 PDF 沒有附上系統定義或圖形；作答時需對照課堂教材。
- Exercise 2(d) 第二式原文為 `I_2 \dot\omega_2 = (I_3-I_3)\omega_3\omega_1`。主檔忠實保留，未自行更正；請向授課教師確認。
- Exercise 6 前兩式的最高階導數皆為 `\ddot q_1`，依原文保留。
