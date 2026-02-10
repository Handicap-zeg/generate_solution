目录结构
mathfusionqa_math/: 原始 Parquet 数据集文件夹。

step1_generate_solutions.py: 核心推理脚本（分片）。

run_parallel.sh: 自动检测 GPU 并启动多进程并行的 shell 脚本。

merge_shards.py: 合并所有 GPU 输出结果并转换为训练格式。

环境准备
执行：
Bash
pip install -r requirements.txt
注：建议 vLLM 版本 >= 0.6.0 以适配 QwQ 模型。

开始

1. 配置路径
   打开 step1_generate_solutions.py，,模型的huggingface路径为https://huggingface.co/Qwen/QwQ-32B ，修改顶部的QWQ-32B模型路径：

Python
QWQ_MODEL_PATH = "/你的模型实际路径/QwQ-32B"

2. 赋予权限并运行


Bash
chmod +x run_parallel.sh
./run_parallel.sh


3.任务完成后，合并后的数据将保存在 mathfusionqa_math_qwq/ 目录下：

train_alpaca.json: 过滤掉无效回答后的最终训练数据（Alpaca 格式）。

mathfusion_math_qwq32b_solutions.json: 包含原始字段和新生成的完整数据。

说明：
显存：默认 tp=1，单进程约需 65GB+ 显存。如果显存不足，请在 run_parallel.sh 中将 --tp 1 改为 --tp 2或更多。
