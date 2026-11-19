# HW6 Exercise 2：Laplace 解法複習

題目系統可寫成
\[
\dot{x}=Ax+Bu,\qquad y=Cx+Du,
\]
其中
\[
B=\begin{bmatrix}0\\0\\1\\0\end{bmatrix},\qquad
C=\begin{bmatrix}0&0&1&0\end{bmatrix},\qquad D=0.
\]

零初始條件下，轉移函數為
\[
\hat G(s)=C(sI-A)^{-1}B+D.
\]
令
\[
X(s)=(sI-A)^{-1}B,
\]
就可以解線性方程組
\[
(sI-A)X(s)=B.
\]
由於 $B$ 的第 3 個分量為 1，其餘為 0，$(sI-A)^{-1}B$ 是 $(sI-A)^{-1}$ 的**第 3 欄**（不是第 3 列）。對本題逐列解得
\[
X_1(s)=0,\qquad X_2(s)=0,\qquad X_3(s)=\frac{1}{s+3},\qquad
X_4(s)=\frac{1}{(s-1)(s+3)}.
\]
輸出矩陣 $C$ 只取出 $X_3(s)$，因此
\[
\hat G(s)=CX(s)+D=\frac{1}{s+3}.
\]
反 Laplace 轉換後，脈衝響應為
\[
G(t)=e^{-3t},\qquad t\ge 0.
\]

雖然 $A$ 的 modes 為 $e^{-t},e^{-2t},e^{-3t},e^t$，輸入到輸出的脈衝響應只含 $e^{-3t}$。其中 $X_4(s)$ 有 pole $s=1$，對應 $x_4(t)$ 中的 $e^t$；但 $C$ 不讀取 $x_4$，所以這個 mode 不出現在輸出脈衝響應中。
