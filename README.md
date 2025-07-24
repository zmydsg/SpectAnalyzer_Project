# SpectAnalyzer - FPGA频谱分析仪

一个基于FPGA的实时频谱分析仪项目，使用VHDL实现8点FFT算法，可以对输入的ADC采样数据进行频谱分析并输出功率谱密度。

## 🚀 项目特性

- **实时频谱分析**: 支持连续的ADC数据流输入和频谱输出
- **8点FFT**: 实现了高效的8点快速傅里叶变换算法
- **功率谱计算**: 输出|X(k)|²形式的功率谱密度
- **流水线设计**: 采用三阶段流水线架构（输入缓冲→FFT处理→输出缓冲）
- **资源优化**: 使用单端口RAM实现数据存储，节省FPGA资源
- **位逆序输入**: 自动处理FFT所需的位逆序数据排列

## 📋 技术规格

| 参数 | 值 | 说明 |
|------|----|----------|
| 数据位宽 | 16位 | Q1.15定点格式 |
| FFT点数 | 8点 | 可分析8个频率分量 |
| 存储深度 | 16 | 实部/虚部交织存储 |
| 时钟域 | 单时钟 | 同步设计 |
| 目标器件 | Intel/Altera FPGA | 使用Quartus Prime开发 |

## 🏗️ 系统架构

```
ADC采样 → 输入缓冲 → FFT处理 → 输出缓冲 → 频谱输出
    ↓         ↓         ↓         ↓         ↓
  16位     位逆序    8点FFT    功率谱    |X(k)|²
  Q1.15    存储      蝶形运算   计算      输出
```

### 核心模块

1. **<mcfile name="SpectAnalyzer_top.vhd" path="src/SpectAnalyzer_top.vhd"></mcfile>** - 顶层模块，实现三阶段状态机控制
2. **<mcfile name="input_buffer.vhd" path="src/input_buffer.vhd"></mcfile>** - 输入缓冲模块，处理ADC数据并进行位逆序排列
3. **<mcfile name="mag_sqr_fft.vhd" path="src/mag_sqr_fft.vhd"></mcfile>** - FFT核心模块，实现8点FFT和功率谱计算
4. **<mcfile name="output_buffer.vhd" path="src/output_buffer.vhd"></mcfile>** - 输出缓冲模块，按序输出频谱数据
5. **<mcfile name="ram_sp.vhd" path="src/ram_sp.vhd"></mcfile>** - 单端口RAM模块
6. **<mcfile name="spect_pkg.vhd" path="src/spect_pkg.vhd"></mcfile>** - 公共包文件，定义常量和数据类型

## 🔧 快速开始

### 环境要求

- Intel Quartus Prime (推荐版本 18.0+)
- ModelSim (可选，用于仿真验证)
- 支持的FPGA开发板

### 编译步骤

1. **克隆项目**
   ```bash
   git clone https://github.com/your-username/SpectAnalyzer_Project.git
   cd SpectAnalyzer_Project
   ```

2. **打开Quartus项目**
   ```bash
   quartus SpectAnalyzer.qpf
   ```

3. **编译项目**
   - 在Quartus中点击 "Start Compilation"
   - 或使用命令行：`quartus_sh --flow compile SpectAnalyzer_top`

4. **下载到FPGA**
   - 连接FPGA开发板
   - 使用Programmer下载生成的.sof文件

### 仿真验证

项目包含完整的测试平台，位于 `src/tb/` 目录：

```bash
# 编译仿真库
vsim -do scripts/modelsim_compile.tcl

# 运行顶层仿真
cd src/tb/top
vsim -do run.do
```

## 📊 接口说明

### 输入接口

| 信号名 | 方向 | 位宽 | 说明 |
|--------|------|------|------|
| `clk` | 输入 | 1 | 系统时钟 |
| `rst_n` | 输入 | 1 | 异步复位（低有效） |
| `adc_sample` | 输入 | 16 | ADC采样数据（Q1.15格式） |
| `adc_valid` | 输入 | 1 | ADC数据有效信号 |
| `adc_ready` | 输出 | 1 | 系统准备接收数据信号 |

### 输出接口

| 信号名 | 方向 | 位宽 | 说明 |
|--------|------|------|------|
| `dout` | 输出 | 16 | 频谱输出数据|X(k)|² |
| `dout_valid` | 输出 | 1 | 输出数据有效信号 |

## 🔬 工作原理

### 数据流程

1. **数据采集**: 系统接收16位ADC采样数据，采用Q1.15定点格式
2. **缓冲存储**: 输入缓冲模块收集8个采样点，并按位逆序存储到RAM中
3. **FFT计算**: 使用基-2时间抽取算法实现8点FFT，包含3级蝶形运算
4. **功率谱计算**: 计算每个频率分量的功率谱密度 |X(k)|² = Re²(k) + Im²(k)
5. **结果输出**: 按序输出8个频率分量的功率谱值

### FFT算法实现

- **算法**: 基-2时间抽取(DIT)FFT
- **级数**: 3级蝶形运算 (log₂8 = 3)
- **旋转因子**: 预计算的正弦/余弦系数表
- **数值格式**: Q1.15定点运算，包含饱和处理

## 📁 项目结构

```
SpectAnalyzer_Project/
├── src/                    # 源代码目录
│   ├── SpectAnalyzer_top.vhd      # 顶层模块
│   ├── input_buffer.vhd           # 输入缓冲
│   ├── mag_sqr_fft.vhd           # FFT核心
│   ├── output_buffer.vhd          # 输出缓冲
│   ├── ram_sp.vhd                 # 单端口RAM
│   ├── spect_pkg.vhd              # 公共包
│   ├── spect_pkg0.vhd             # 辅助函数包
│   └── tb/                        # 测试平台
├── db/                     # Quartus数据库文件
├── incremental_db/         # 增量编译数据库
├── SpectAnalyzer.qpf      # Quartus项目文件
├── SpectAnalyzer_top.qsf  # Quartus设置文件
└── *.rpt                  # 编译报告文件
```

## 🎯 应用场景

- **信号处理教学**: 理解FFT算法的FPGA实现
- **频谱分析**: 实时音频/射频信号频谱分析
- **算法验证**: FFT算法的硬件验证平台
- **原型开发**: 更复杂频谱分析系统的基础模块

## 🔧 自定义配置

### 修改FFT点数

在 <mcfile name="spect_pkg.vhd" path="src/spect_pkg.vhd"></mcfile> 中修改：

```vhdl
constant N_POINTS : natural := 16;  -- 改为16点FFT
```

### 修改数据位宽

```vhdl
constant DATA_WIDTH : natural := 18;  -- 改为18位数据
```

**注意**: 修改这些参数需要相应调整FFT算法实现和旋转因子表。

## 📈 性能指标

- **处理延迟**: 约20-30个时钟周期（取决于时钟频率）
- **吞吐率**: 每8个输入采样产生8个频谱输出
- **资源占用**: 
  - 逻辑单元: ~500 LEs
  - 存储器: 1个M9K块
  - DSP: 2-4个乘法器

## 🤝 贡献指南

欢迎提交Issue和Pull Request！

1. Fork本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启Pull Request

## 📄 许可证

本项目采用MIT许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 联系方式

- 作者邮箱:zgotohdx@outlook.com 

## 🙏 致谢

- 感谢所有为FPGA开源社区做出贡献的开发者
- 参考了经典的FFT算法实现文献
- 使用了Intel/Altera的FPGA开发工具链

---

⭐ 如果这个项目对您有帮助，请给个Star支持一下！


# SpectAnalyzer - FPGA Spectrum Analyzer

A real-time spectrum analyzer project based on FPGA, implementing 8-point FFT algorithm using VHDL for spectrum analysis of input ADC sampling data and power spectral density output.

## 🚀 Features

- **Real-time Spectrum Analysis**: Supports continuous ADC data stream input and spectrum output
- **8-point FFT**: Implements efficient 8-point Fast Fourier Transform algorithm
- **Power Spectrum Calculation**: Outputs power spectral density in |X(k)|² format
- **Pipeline Design**: Uses three-stage pipeline architecture (Input Buffer → FFT Processing → Output Buffer)
- **Resource Optimization**: Uses single-port RAM for data storage, saving FPGA resources
- **Bit-reversed Input**: Automatically handles bit-reversed data arrangement required by FFT

## 📋 Technical Specifications

| Parameter | Value | Description |
|-----------|-------|-------------|
| Data Width | 16-bit | Q1.15 fixed-point format |
| FFT Points | 8-point | Can analyze 8 frequency components |
| Storage Depth | 16 | Real/Imaginary interleaved storage |
| Clock Domain | Single clock | Synchronous design |
| Target Device | Intel/Altera FPGA | Developed with Quartus Prime |

## 🏗️ System Architecture
ADC Sampling → Input Buffer → FFT Processing → Output Buffer → Spectrum Output
↓             ↓              ↓              ↓              ↓
16-bit      Bit-reverse     8-point FFT    Power Spectrum   |X(k)|²
Q1.15        Storage       Butterfly Ops   Calculation      Output

### Core Modules

1. **SpectAnalyzer_top.vhd** - Top-level module implementing three-stage state machine control
2. **input_buffer.vhd** - Input buffer module handling ADC data and bit-reverse arrangement
3. **mag_sqr_fft.vhd** - FFT core module implementing 8-point FFT and power spectrum calculation
4. **output_buffer.vhd** - Output buffer module for sequential spectrum data output
5. **ram_sp.vhd** - Single-port RAM module
6. **spect_pkg.vhd** - Common package file defining constants and data types

## 🔧 Quick Start

### Requirements

- Intel Quartus Prime (Recommended version 18.0+)
- ModelSim (Optional, for simulation verification)
- Supported FPGA development board

### Compilation Steps

1. **Clone the project**
   ```bash
   git clone https://github.com/your-username/SpectAnalyzer_Project.git
   cd SpectAnalyzer_Project
   ```

2. **Open Quartus project**
   ```bash
   quartus SpectAnalyzer.qpf
   ```

3. **Compile the project**
   - Click "Start Compilation" in Quartus
   - Or use command line: `quartus_sh --flow compile SpectAnalyzer_top`

4. **Download to FPGA**
   - Connect FPGA development board
   - Use Programmer to download the generated .sof file

### Simulation Verification

The project includes complete testbenches located in the `src/tb/` directory:

```bash
# Compile simulation library
vsim -do scripts/modelsim_compile.tcl

# Run top-level simulation
cd src/tb/top
vsim -do run.do
```

## 📊 Interface Description

### Input Interface

| Signal Name | Direction | Width | Description |
|-------------|-----------|-------|-------------|
| `clk` | Input | 1 | System clock |
| `rst_n` | Input | 1 | Asynchronous reset (active low) |
| `adc_sample` | Input | 16 | ADC sampling data (Q1.15 format) |
| `adc_valid` | Input | 1 | ADC data valid signal |
| `adc_ready` | Output | 1 | System ready to receive data signal |

### Output Interface

| Signal Name | Direction | Width | Description |
|-------------|-----------|-------|-------------|
| `dout` | Output | 16 | Spectrum output data |X(k)|² |
| `dout_valid` | Output | 1 | Output data valid signal |

## 🔬 Working Principle

### Data Flow

1. **Data Acquisition**: System receives 16-bit ADC sampling data in Q1.15 fixed-point format
2. **Buffer Storage**: Input buffer module collects 8 sampling points and stores them in bit-reversed order in RAM
3. **FFT Calculation**: Uses radix-2 decimation-in-time algorithm to implement 8-point FFT with 3 stages of butterfly operations
4. **Power Spectrum Calculation**: Calculates power spectral density for each frequency component |X(k)|² = Re²(k) + Im²(k)
5. **Result Output**: Sequentially outputs power spectrum values for 8 frequency components

### FFT Algorithm Implementation

- **Algorithm**: Radix-2 Decimation-in-Time (DIT) FFT
- **Stages**: 3 stages of butterfly operations (log₂8 = 3)
- **Twiddle Factors**: Pre-computed sine/cosine coefficient table
- **Number Format**: Q1.15 fixed-point arithmetic with saturation handling

## 📁 Project Structure
SpectAnalyzer_Project/
├── src/                    # Source code directory
│   ├── SpectAnalyzer_top.vhd      # Top-level module
│   ├── input_buffer.vhd           # Input buffer
│   ├── mag_sqr_fft.vhd           # FFT core
│   ├── output_buffer.vhd          # Output buffer
│   ├── ram_sp.vhd                 # Single-port RAM
│   ├── spect_pkg.vhd              # Common package
│   ├── spect_pkg0.vhd             # Utility function package
│   └── tb/                        # Testbench
├── db/                     # Quartus database files
├── incremental_db/         # Incremental compilation database
├── SpectAnalyzer.qpf      # Quartus project file
├── SpectAnalyzer_top.qsf  # Quartus settings file
└── *.rpt                  # Compilation report files

## 🎯 Application Scenarios

- **Signal Processing Education**: Understanding FPGA implementation of FFT algorithms
- **Spectrum Analysis**: Real-time audio/RF signal spectrum analysis
- **Algorithm Verification**: Hardware verification platform for FFT algorithms
- **Prototype Development**: Foundation module for more complex spectrum analysis systems

## 🔧 Custom Configuration

### Modify FFT Points

Modify in `spect_pkg.vhd`:

```vhdl
constant N_POINTS : natural := 16;  -- Change to 16-point FFT
```

### Modify Data Width

```vhdl
constant DATA_WIDTH : natural := 18;  -- Change to 18-bit data
```

**Note**: Modifying these parameters requires corresponding adjustments to the FFT algorithm implementation and twiddle factor tables.

## 📈 Performance Metrics

- **Processing Latency**: Approximately 20-30 clock cycles (depending on clock frequency)
- **Throughput**: 8 spectrum outputs per 8 input samples
- **Resource Usage**: 
  - Logic Elements: ~500 LEs
  - Memory: 1 M9K block
  - DSP: 2-4 multipliers

## 🤝 Contributing

Welcome to submit Issues and Pull Requests!

1. Fork this project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

- Author Email: zgotohdx@outlook.com

## 🙏 Acknowledgments

- Thanks to all developers who contribute to the FPGA open source community
- Referenced classic FFT algorithm implementation literature
- Used Intel/Altera FPGA development toolchain

---

⭐ If this project helps you, please give it a Star!