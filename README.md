# SpectAnalyzer - FPGA 8-Point FFT Spectrum Analyzer

## English
**Overview**  
Real-time spectrum analyzer in VHDL with an 8-point Q1.15 FFT, power spectrum `|X(k)|^2`, and a three-stage pipeline (input buffer -> FFT -> output buffer), targeting Intel/Altera FPGAs.

**Features**  
- 8-point radix-2 DIT FFT, three butterfly stages, streaming ADC with bit-reversed buffering.  
- Power spectrum via Re/Im square sum; single-port RAM to save resources.  
- Defaults: `DATA_WIDTH=16`, `N_POINTS=8`, single clock domain; configurable in `src/spect_pkg.vhd`.

**Environment**  
- Quartus Prime 18.0+ (required)  
- ModelSim (optional, simulation)  
- Intel/Altera FPGA board

**Quick Start**  
1) Clone  
```bash
git clone https://github.com/your-username/SpectAnalyzer_Project.git
cd SpectAnalyzer_Project
```  
2) Build  
- GUI: open `SpectAnalyzer.qpf`, click “Start Compilation”  
- CLI: `quartus_sh --flow compile SpectAnalyzer_top`  
3) Program  
- Use Programmer to write the generated `.sof` to the board.

**Simulation**  
```bash
vsim -do scripts/modelsim_compile.tcl   # compile libs
cd src/tb/top
vsim -do run.do                         # top simulation
```

**Layout**  
```
src/
  SpectAnalyzer_top.vhd    # top-level control
  input_buffer.vhd         # input buffer + bit-reverse write
  mag_sqr_fft.vhd          # FFT + power spectrum
  output_buffer.vhd        # ordered spectrum output
  ram_sp.vhd               # single-port RAM
  spect_pkg.vhd            # params & types
  spect_pkg0.vhd           # helpers
  tb/                      # testbench
SpectAnalyzer.qpf          # Quartus project
SpectAnalyzer_top.qsf      # Quartus settings
```

**Interfaces**  
- Input: `clk`, `rst_n` (active-low), `adc_sample[15:0]`, `adc_valid`, handshake `adc_ready`  
- Output: `dout[15:0]` (power spectrum `|X(k)|^2`), `dout_valid`

**Tuning**  
- FFT points: edit `N_POINTS` in `src/spect_pkg.vhd`  
- Data width: edit `DATA_WIDTH`  
Update twiddle tables and fixed-point scaling accordingly.

**License & Contact**  
- License: MIT, see `LICENSE`  
- Email: zgotohdx@outlook.com  
If this project helps you, please give it a Star. Thanks!

---

## 中文版
**简介**  
基于 VHDL 的实时频谱分析项目，默认 8 点 Q1.15 定点输入，输出功率谱 `|X(k)|^2`，三段流水线（输入缓冲 -> FFT -> 输出缓冲），面向 Intel/Altera FPGA。

**特性**  
- 8 点基 2 DIT FFT，3 级蝶形，连续 ADC 数据流与位逆序缓冲。  
- 功率谱：实/虚部平方求和；单口 RAM 节省资源。  
- 默认参数：`DATA_WIDTH=16`，`N_POINTS=8`，单时钟域；可在 `src/spect_pkg.vhd` 调整。

**环境**  
- Quartus Prime 18.0+（必需）  
- ModelSim（可选，仿真）  
- Intel/Altera FPGA 开发板

**快速上手**  
1) 克隆  
```bash
git clone https://github.com/your-username/SpectAnalyzer_Project.git
cd SpectAnalyzer_Project
```  
2) 编译  
- GUI：打开 `SpectAnalyzer.qpf`，点击 “Start Compilation”  
- CLI：`quartus_sh --flow compile SpectAnalyzer_top`  
3) 烧录  
- 用 Programmer 将生成的 `.sof` 写入开发板。

**仿真**  
```bash
vsim -do scripts/modelsim_compile.tcl   # 编译库
cd src/tb/top
vsim -do run.do                         # 顶层仿真
```

**目录**  
```
src/
  SpectAnalyzer_top.vhd    # 顶层控制
  input_buffer.vhd         # 输入缓冲+位逆序写
  mag_sqr_fft.vhd          # FFT + 功率谱
  output_buffer.vhd        # 顺序输出频谱
  ram_sp.vhd               # 单口 RAM
  spect_pkg.vhd            # 参数/类型定义
  spect_pkg0.vhd           # 辅助函数
  tb/                      # 测试平台
SpectAnalyzer.qpf          # Quartus 工程
SpectAnalyzer_top.qsf      # Quartus 设置
```

**接口**  
- 输入：`clk`，`rst_n`(低有效)，`adc_sample[15:0]`，`adc_valid`，握手 `adc_ready`  
- 输出：`dout[15:0]`（功率谱 `|X(k)|^2`），`dout_valid`

**参数调整**  
- FFT 点数：修改 `src/spect_pkg.vhd` 的 `N_POINTS`  
- 数据位宽：修改 `DATA_WIDTH`  
参数变更需同步更新旋转因子表与定点位宽处理。

**许可证与联系**  
- 许可证：MIT，见 `LICENSE`  
- 邮箱：zgotohdx@outlook.com  
如果本项目对你有帮助，欢迎点个 Star；谢谢！
