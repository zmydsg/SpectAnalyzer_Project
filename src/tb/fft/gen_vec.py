#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
生成 mag_sqr_fft 的 3 组测试向量（Q1.15）：
   • impulse  • tone1  • random
文件输出：
   ./stim/impulse_in.bin   ./stim/impulse_gold.bin
   ./stim/tone1_in.bin     ./stim/tone1_gold.bin
   ./stim/random_in.bin    ./stim/random_gold.bin
按 Re0,Im0,Re1,Im1… 的交织格式存储为 **big-endian int16**，
与 tb_mag_sqr_fft.vhd 的行为 RAM 模型一一对应。
"""

from pathlib import Path
import numpy as np

# ──────────────────────────────────────────────────────────────
# 参数
# ──────────────────────────────────────────────────────────────
N_POINTS = 8           # VHDL generic N_POINTS
SCALE    = 32768       # 2^15，用于 Q1.15 量化

# 根目录：脚本所在目录 /stim
SCRIPT_DIR = Path(__file__).resolve().parent
STIM_DIR   = SCRIPT_DIR / "stim"
STIM_DIR.mkdir(exist_ok=True)

# ──────────────────────────────────────────────────────────────
# 工具函数
# ──────────────────────────────────────────────────────────────
def to_q15(array_f):
    """浮点 -> 饱和 Q1.15 (int16)"""
    return np.int16(np.clip(np.round(array_f * SCALE), -32768, 32767))

def save_vector(name: str, cplx: np.ndarray):
    """
    生成 <name>_in.bin 和 <name>_gold.bin
    参数:
        name – 文件名前缀
        cplx – N 维复数序列
    """
    # ---------- 输入文件 ----------
    re = to_q15(cplx.real)
    im = to_q15(cplx.imag)
    interleaved = np.empty(2 * N_POINTS, dtype=">i2")  # 大端
    interleaved[0::2] = re.astype(">i2")
    interleaved[1::2] = im.astype(">i2")
    (STIM_DIR / f"{name}_in.bin").write_bytes(interleaved.tobytes())

    # ---------- 黄金幅度平方 ----------
    X     = np.fft.fft(cplx, N_POINTS)
    mag2  = np.abs(X) ** 2
    gold  = to_q15(mag2 / SCALE)              # 右移 15 位
    (STIM_DIR / f"{name}_gold.bin").write_bytes(gold.astype(">i2").tobytes())

    print(f"[OK] {name}  →  {name}_in.bin / {name}_gold.bin")

# ──────────────────────────────────────────────────────────────
# 生成三组向量
# ──────────────────────────────────────────────────────────────
if __name__ == "__main__":
    # ① 冲激
    v_imp = np.zeros(N_POINTS, dtype=np.complex64)
    v_imp[0] = 1
    save_vector("impulse", v_imp)

    # ② k=1 单频
    k  = 1
    n  = np.arange(N_POINTS)
    v_tone = np.exp(2j * np.pi * k * n / N_POINTS)
    save_vector("tone1", v_tone)

    # ③ 随机高斯（固定种子保证可复现）
    rng = np.random.default_rng(42)
    v_rand = (rng.normal(0, 0.5, N_POINTS) +
              1j * rng.normal(0, 0.5, N_POINTS)).astype(np.complex64)
    save_vector("random", v_rand)

    print(f"\n全部文件已生成到: {STIM_DIR.as_posix()}")
