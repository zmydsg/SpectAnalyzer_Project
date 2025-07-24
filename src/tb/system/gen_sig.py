import numpy as np, os, pathlib, textwrap

ROOT = pathlib.Path(__file__).parent   # 就是 …/src/tb/system
N, M = 8, 16
S    = 2**(M-1)

def q15(x): return np.int16(np.clip(np.round(x*S), -32768, 32767))
def dump_hex(path, vec): np.savetxt(path, vec & 0xFFFF, fmt="%04X")

n = np.arange(32)                                 # ≥3N
# 1) 冲激
dump_hex(ROOT/"sig_A.hex", q15(np.concatenate(([1.0], np.zeros(31)))))
# 2) 单频
dump_hex(ROOT/"sig_B.hex", q15(np.cos(2*np.pi*1*n/N)))
# 3) 双音+噪声
rng = np.random.default_rng(0)
xC  = 0.7*np.cos(2*np.pi*1*n/N)+0.4*np.cos(2*np.pi*2*n/N)+0.05*rng.normal(32)
dump_hex(ROOT/"sig_C.hex", q15(xC))

# === 黄金参考：冲激为例；其它信号同理 ========================
y  = np.fft.fft(q15(np.concatenate(([1.0], np.zeros(N-1)))))  # 截前 N 点
mag2 = q15(y.real**2 + y.imag**2)
dump_hex(ROOT/"gold_A.hex", mag2)
