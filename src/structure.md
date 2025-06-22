SpectAnalyzer_Project/
│
├─ rtl/                         -- ★ 所有可综合 RTL（按功能拆子目录）
│   ├─ common/                  -- 公共宏/包
│   │   └─ spect_pkg.vhd
│   ├─ input/                   -- 输入采样缓冲
│   │   └─ input_buffer.vhd
│   ├─ ram/                     -- 片内 RAM / FIFO
│   │   └─ ram_sp.vhd
│   ├─ fft/                     -- FFT + |X|²
│   │   └─ mag_sqr_fft.vhd
│   └─ top/                     -- 最终封装 / 约束
│       └─ spect_analyzer_top.vhd
│
├─ tb/                          -- ★ 单元测试（与 rtl/* 一一对应）
│   ├─ common/                  -- 仿真共用工具包 / task
│   │   └─ tb_pkg.vhd
│   │
│   ├─ input/
│   │   ├─ tb_input_buffer.vhd
│   │   ├─ stim/                -- *.bin / *.txt 激励、golden
│   │   └─ run.do               -- vsim 批跑脚本
│   │
│   ├─ ram/
│   │   ├─ tb_ram_sp.vhd
│   │   ├─ stim/
│   │   └─ run.do
│   │
│   ├─ fft/
│   │   ├─ tb_mag_sqr_fft.vhd
│   │   ├─ gen_vec.py           -- 生成 3 组向量
│   │   ├─ stim/
│   │   │   ├─ impulse_in.bin
│   │   │   ├─ impulse_gold.bin
│   │   │   ├─ tone1_in.bin
│   │   │   ├─ tone1_gold.bin
│   │   │   ├─ random_in.bin
│   │   │   └─ random_gold.bin
│   │   └─ run.do
│   │
│   └─ top/                     -- DUT=顶层（系统级冒烟仿真）
│       ├─ tb_spect_analyzer.vhd
│       └─ run.do
│
├─ scripts/                     -- ★ 一键构建 / 约束脚本
│   ├─ modelsim_compile.tcl     -- 全局 compile 库脚本，被各 run.do 调
│   ├─ quartus_create.qpf
│   └─ quartus_compile.tcl
│
├─ doc/                         -- 设计文档、需求、报告
│   ├─ 课程设计要求.docx
│   └─ 正文.docx
│
└─ report/                      -- ModelSim transcr/WLF 截图、Quartus 报告
    ├─ sim_log/
    └─ timing_util.html
