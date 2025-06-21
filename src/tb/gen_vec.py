import numpy as np

# ------- 采样向量：16 个 Q1.15 值（Re0, Im0, Re1, Im1, ...）-------
x = np.array([1,0,0.7071,0,0,0,-0.7071,0,-1,0,-0.7071,0,0,0,0.7071,0])

# ------- 固定点量化 -------
xq = (x * 32768).round().astype(int)           # Q1.15 → 整数

# ------- 8 点复数 -------
z = xq[::2] + 1j * xq[1::2]

# ------- FFT 幅度平方 -------
X = np.fft.fft(z)                              # FFT
mag2 = (np.abs(X)**2).round().astype(int)      # Q2.30
mag2 = (mag2 >> 15) & 0xFFFF                   # Q1.15

# ------- 打印 VHDL 常量 -------
print("constant stim : vec16_t := (")
for v in xq:
    print(f"    to_signed({v if v<32768 else v-65536}, 16),")
print(");\n")

print("constant ref_mag2 : vec16_t := (")
for i,v in enumerate(mag2):
    print(f"    {i} => to_signed({v if v<32768 else v-65536}, 16),")
print("    others => (others=>'0'));")
