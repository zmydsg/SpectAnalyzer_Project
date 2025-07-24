import numpy as np
import matplotlib.pyplot as plt
import pathlib
from matplotlib.patches import Rectangle
import matplotlib.patches as mpatches

# 设置中文字体和工程风格
plt.rcParams['font.sans-serif'] = ['SimHei', 'Arial Unicode MS']
plt.rcParams['axes.unicode_minus'] = False
plt.rcParams['figure.facecolor'] = 'white'
plt.rcParams['axes.grid'] = True
plt.rcParams['grid.alpha'] = 0.3

# 工程参数
ROOT = pathlib.Path("src/tb/system")
N, M = 8, 16  # FFT点数，数据位宽
S = 2**(M-1)  # Q15格式缩放因子
Fs = 1000     # 假设采样频率1kHz（工程中需要根据实际情况调整）

def hex_to_q15(hex_file):
    """将十六进制文件转换为Q15格式的浮点数"""
    with open(hex_file, 'r') as f:
        hex_values = [line.strip() for line in f if line.strip()]
    
    # 转换为有符号16位整数，再转换为Q15浮点数
    int_values = [int(h, 16) for h in hex_values]
    # 处理有符号数（16位补码）
    signed_values = [(v if v < 32768 else v - 65536) for v in int_values]
    q15_values = np.array(signed_values) / S
    return q15_values

def analyze_signal(signal, name, fs=Fs):
    """分析信号的工程特性"""
    # 时域特性
    rms = np.sqrt(np.mean(signal**2))
    peak = np.max(np.abs(signal))
    crest_factor = peak / rms if rms > 0 else 0
    
    # 频域分析
    N_fft = len(signal)
    fft_result = np.fft.fft(signal, N_fft)
    magnitude = np.abs(fft_result)
    phase = np.angle(fft_result)
    freq = np.fft.fftfreq(N_fft, 1/fs)
    
    # 功率谱密度
    psd = magnitude**2 / N_fft
    
    print(f"\n=== {name} 信号工程参数 ===")
    print(f"RMS值: {rms:.4f}")
    print(f"峰值: {peak:.4f}")
    print(f"峰值因子: {crest_factor:.2f}")
    print(f"动态范围: {20*np.log10(peak/max(1e-10, rms)):.1f} dB")
    
    return {
        'signal': signal,
        'fft': fft_result,
        'magnitude': magnitude,
        'phase': phase,
        'freq': freq,
        'psd': psd,
        'rms': rms,
        'peak': peak,
        'crest_factor': crest_factor
    }

# 读取三个信号
signals = {}
try:
    signals['A'] = hex_to_q15(ROOT / "sig_A.hex")
    signals['B'] = hex_to_q15(ROOT / "sig_B.hex") 
    signals['C'] = hex_to_q15(ROOT / "sig_C.hex")
except FileNotFoundError as e:
    print(f"文件未找到: {e}")
    print("请确保在项目根目录运行此脚本")
    exit(1)

# 分析信号
analysis = {}
for name, sig in signals.items():
    analysis[name] = analyze_signal(sig, f"信号{name}")

# 创建专业的可视化图表
fig = plt.figure(figsize=(16, 12))
fig.suptitle('频谱分析仪输入信号特性分析', fontsize=16, fontweight='bold')

# 时域波形对比
ax1 = plt.subplot(3, 3, (1, 3))
t = np.arange(len(signals['A'])) / Fs * 1000  # 转换为毫秒

colors = ['#1f77b4', '#ff7f0e', '#2ca02c']
for i, (name, sig) in enumerate(signals.items()):
    ax1.plot(t, sig, colors[i], linewidth=2, label=f'信号{name}', marker='o', markersize=4)

ax1.set_xlabel('时间 (ms)')
ax1.set_ylabel('幅度 (Q15)')
ax1.set_title('时域波形对比', fontweight='bold')
ax1.legend()
ax1.grid(True, alpha=0.3)
ax1.set_ylim(-1.1, 1.1)

# 频域幅度谱
ax2 = plt.subplot(3, 3, (4, 6))
for i, (name, data) in enumerate(analysis.items()):
    freq_positive = data['freq'][:len(data['freq'])//2]
    mag_positive = data['magnitude'][:len(data['magnitude'])//2]
    ax2.plot(freq_positive, 20*np.log10(mag_positive + 1e-10), 
             colors[i], linewidth=2, label=f'信号{name}')

ax2.set_xlabel('频率 (Hz)')
ax2.set_ylabel('幅度 (dB)')
ax2.set_title('频域幅度谱', fontweight='bold')
ax2.legend()
ax2.grid(True, alpha=0.3)

# 各信号详细分析
for i, (name, data) in enumerate(analysis.items()):
    # 时域详细视图
    ax = plt.subplot(3, 3, 7+i)
    ax.plot(t, data['signal'], colors[i], linewidth=2, marker='o', markersize=3)
    ax.set_title(f'信号{name} - 时域', fontweight='bold')
    ax.set_xlabel('时间 (ms)')
    ax.set_ylabel('幅度')
    ax.grid(True, alpha=0.3)
    
    # 添加工程参数文本
    textstr = f'RMS: {data["rms"]:.3f}\nPeak: {data["peak"]:.3f}\nCF: {data["crest_factor"]:.1f}'
    props = dict(boxstyle='round', facecolor='wheat', alpha=0.8)
    ax.text(0.02, 0.98, textstr, transform=ax.transAxes, fontsize=8,
            verticalalignment='top', bbox=props)

plt.tight_layout()

# 创建第二个图：工程分析图表
fig2 = plt.figure(figsize=(14, 10))
fig2.suptitle('工程特性分析', fontsize=16, fontweight='bold')

# 功率谱密度对比
ax1 = plt.subplot(2, 2, 1)
for i, (name, data) in enumerate(analysis.items()):
    freq_positive = data['freq'][:len(data['freq'])//2]
    psd_positive = data['psd'][:len(data['psd'])//2]
    ax1.semilogy(freq_positive, psd_positive, colors[i], linewidth=2, label=f'信号{name}')

ax1.set_xlabel('频率 (Hz)')
ax1.set_ylabel('功率谱密度')
ax1.set_title('功率谱密度对比', fontweight='bold')
ax1.legend()
ax1.grid(True, alpha=0.3)

# 信号特性雷达图
ax2 = plt.subplot(2, 2, 2, projection='polar')
categories = ['RMS', '峰值', '峰值因子']
angles = np.linspace(0, 2*np.pi, len(categories), endpoint=False).tolist()
angles += angles[:1]  # 闭合图形

for i, (name, data) in enumerate(analysis.items()):
    values = [data['rms'], data['peak'], data['crest_factor']/10]  # 归一化峰值因子
    values += values[:1]  # 闭合图形
    ax2.plot(angles, values, colors[i], linewidth=2, label=f'信号{name}')
    ax2.fill(angles, values, colors[i], alpha=0.1)

ax2.set_xticks(angles[:-1])
ax2.set_xticklabels(categories)
ax2.set_title('信号特性对比', fontweight='bold', pad=20)
ax2.legend(loc='upper right', bbox_to_anchor=(1.2, 1.0))

# 频谱瀑布图（3D效果）
ax3 = plt.subplot(2, 2, (3, 4))
freq_bins = analysis['A']['freq'][:len(analysis['A']['freq'])//2]
signal_names = list(analysis.keys())

# 创建瀑布图数据
waterfall_data = np.zeros((len(signal_names), len(freq_bins)))
for i, (name, data) in enumerate(analysis.items()):
    waterfall_data[i, :] = 20*np.log10(data['magnitude'][:len(freq_bins)] + 1e-10)

im = ax3.imshow(waterfall_data, aspect='auto', cmap='viridis', 
                extent=[freq_bins[0], freq_bins[-1], 0, len(signal_names)])
ax3.set_xlabel('频率 (Hz)')
ax3.set_ylabel('信号')
ax3.set_title('频谱瀑布图', fontweight='bold')
ax3.set_yticks(range(len(signal_names)))
ax3.set_yticklabels([f'信号{name}' for name in signal_names])
cbar = plt.colorbar(im, ax=ax3)
cbar.set_label('幅度 (dB)')

plt.tight_layout()

# 生成工程报告
print("\n" + "="*50)
print("频谱分析仪输入信号工程报告")
print("="*50)
print(f"采样频率: {Fs} Hz")
print(f"数据格式: Q15 ({M}位)")
print(f"信号长度: {len(signals['A'])} 点")
print(f"频率分辨率: {Fs/len(signals['A']):.2f} Hz")

print("\n信号类型识别:")
for name, data in analysis.items():
    if name == 'A':
        print(f"信号{name}: 冲激信号 (用于系统冲激响应测试)")
    elif name == 'B':
        print(f"信号{name}: 单频正弦波 (频率: {Fs/N:.1f} Hz)")
    elif name == 'C':
        print(f"信号{name}: 复合信号 (双音+噪声，用于非线性测试)")

print("\n建议的测试用途:")
print("- 信号A: 系统冲激响应、传递函数测量")
print("- 信号B: 频率响应校准、单音失真测试")
print("- 信号C: 动态范围测试、互调失真分析")

plt.show()

print("\n可视化完成！图表已显示。")