# 该示例的研究目标

该文件夹包括若干示例，用于实现地震层析成像中的常见任务，包括：

1. 处理地震到时数据，适用于地震层析成像。
2. 设计检测板实验，确定数据分辨能力。
3. 开展真实数据近震走时层析成像与地震定位。
4. 结果绘图。

## 研究步骤

### 预备工作：程序安装

在命令行中执行：

```bash
conda create -n tomoatt_conda
```

创建新的 conda 环境。然后使用 conda 进行 TomoATT 和 PyTomoATT 的快捷安装：

```bash
conda install tomoatt pytomoatt
```

其中，TomoATT 是基于 C++ 语言开发的成像软件，官网链接为 [https://tomoatt.com](https://tomoatt.com)。PyTomoATT 是 Python 模组，用于处理 TomoATT 的输入和输出文件，官网链接为 [PyTomoATT 文档](https://tomoatt.github.io/PyTomoATT/index.html)。

安装完成之后，可以切换到 conda 环境：

```bash
conda activate tomoatt_conda
```

测试 TomoATT 版本：

```bash
TOMOATT -v
```

测试 PyTomoATT 的安装情况：

```bash
pta -h
```

### 第一步：走时数据处理

获得可靠走时数据是可靠反演的基础。该示例提供 5 个走时处理脚本，旨在保留研究区域内的可靠数据，删除研究区域外以及相对不可靠的数据。具体步骤包括：

#### 1. 确定研究区域，并删除研究区域之外的地震

涉及脚本：

- `DataProc1_删除研究区域外的数据.ipynb`

该脚本用于确定研究区域，并删除研究区域之外的地震与台站。根据需要，研究区域可以进行旋转。

#### 2. 使用线性回归，删除残差较大的数据

涉及脚本：

- `DataProc2_使用线性回归保留可靠数据.ipynb`

该脚本绘制震源距-首达走时散点图，并使用线性回归的方式删除误差较大的走时数据。

#### 3. 删除到时数量较少的地震

涉及脚本：

- `DataProc3_删除少于指定数量数据的地震.ipynb`

该脚本可用于删除到时少于特定数量的地震数据。当走时数据较少时，其震源参数难以准确约束，因此可删除。若用户对震源信息有把握，可以不进行删除。

#### 4. 基于绝对走时数据，生成差分到时

涉及脚本：

- `DataProc4_生成差分到时.ipynb`

该脚本可以基于绝对到时数据，按照一定的筛选原则生成共源差分到时数据或共台差分到时数据。

其中，共源差分到时对震源不确定性不敏感，可用于提高成像可靠性；共台差分到时对台站附近结构不敏感，可用于提高震源相对定位精度以及提高震源附近结构成像分辨率。需要注意的是，共台差分到时更易受到震源不确定性影响，使用该数据需要尽量保证震源信息准确。

#### 5. 可选：给地震与台站赋予权重

涉及脚本：

- `DataProc5_可选_设置数据权重.ipynb`

该脚本可用于给地震与台站赋予权重，在数据分布不均匀的情况下，提升反演收敛速度，缩短收敛所需迭代次数。

该示例反演流程没有添加数据权重，用户可根据实际需要进行添加。

### 第二步：构建反演初始模型

TomoATT 使用迭代法更新模型，因此反演需要提供合适的初始模型。这里提供基于 Crust 1.0 模型生成一维层状模型的脚本。

涉及脚本：

- `ModelProc1_生成初始一维模型.ipynb`

该脚本基于 Crust 1.0 模型生成一维模型。每个深度的速度取当前研究区域中 Crust 1.0 模型的平均速度。

另外，用户可根据需求参考更丰富的模型生成脚本，生成符合自己研究需求的模型。参考链接：[TomoATT HDF5 模型生成脚本](https://tomoatt.com/docs/Tools/scripts_of_generate_hdf5_model/introduction)。

### 第三步：开展反演

#### 1. 一维模型反演

该成像步骤旨在获得合适的初始模型用于地震层析成像。这里“合适的模型”的具体含义是：在该模型下，理论走时和观测走时的残差均值应该在 0 附近，例如其绝对值小于 0.1 秒。

只有走时残差均值在 0 附近，其模型整体速度才没有偏高或者偏低。否则，在后续迭代中，程序会优先恢复速度均值，导致成像结果相对初始模型的扰动整体为正值或负值。不能说这种整体偏高或者偏低的初始模型无法得到好的成像结果，而是会增加反演收敛到局部极小的风险。

地震层析成像本身是一个病态问题，其反演问题通常是多解的。因此，一个合适的模型有助于收敛到更加符合实际的模型。我们需要保证初始模型能够尽量满足走时残差均值在 0 附近。

注释：在一些测试中，我们发现成像结果对初始模型依赖并不强，差异较大的初始模型仍然能够得到一致的反演结果。这种情况通常对地震数据质量和分布有较高要求。

涉及文件：

- `Inversion1_一维模型反演.sh`

在命令行中使用以下命令，通过 TomoATT 进行一维速度模型反演：

```bash
bash Inversion1_一维模型反演.sh
```

该反演使用以下文件：

- 数据文件：`1_src_rec_files/src_rec_file.dat`
- 模型文件：`2_models/model_1d_crust1.0_N31_61_31.h5`
- 参数文件：`3_input_params/input_params_step1_1D_inv.yaml`

反演结果存储在目录 `OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv` 中，重要的输出文件包括：

- 最终模型文件：`OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5`
- 目标函数下降情况：`OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/objective_function.txt`

可使用 `Plot1_画一维模型反演结果.ipynb` 画图展示反演前后的一维模型，以及目标函数下降情况。

#### 2. 开展检测板测试

设计检测板测试旨在评估当前地震数据对速度结构与各向异性的分辨能力。

涉及文件：

- 检测板模型生成脚本：`ModelProc2_生成检测板模型.ipynb`
- 合成数据添加噪声脚本：`DataProc6_ckb_add_noise.py`
- 检测板测试脚本：`Inversion2_检测板测试.sh`

首先，使用 `ModelProc2_生成检测板模型.ipynb`，基于反演得到的一维模型文件 `OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5` 添加高低速异常以及各向异性异常，构建检测板模型。

之后，在命令行中使用以下命令开展检测板测试：

```bash
bash Inversion2_检测板测试.sh
```

检测板测试包括三项步骤：

##### 第一步：计算检测板模型下的观测到时

计算检测板模型下的观测到时，得到检测板测试中的观测信号。该正演使用以下文件：

- 数据文件：`1_src_rec_files/src_rec_file.dat`
- 模型文件：`2_models/model_ckb_N31_61_31.h5`
- 参数文件：`3_input_params/input_params_ckb_signal.yaml`

正演得到的信号文件保存在：

- 检测板观测到时：`OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward.dat`

##### 第二步：给观测信号添加高斯噪声

使用以下 Python 脚本给观测信号添加高斯噪声：

- `DataProc6_ckb_add_noise.py`

处理得到的噪声数据保存在：

- 添加噪声的数据文件：`OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward_noisy.dat`

##### 第三步：开展检测板反演测试

从没有异常的初始模型出发，尝试恢复检测板异常体。该反演使用以下文件：

- 数据文件：`OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward_noisy.dat`
- 模型文件：`OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5`
- 参数文件：`3_input_params/input_params_ckb_inv.yaml`

反演结果存储在目录 `OUTPUT_FILES/OUTPUT_FILES_ckb_inv` 中，重要的输出文件包括：

- 最终模型文件：`OUTPUT_FILES/OUTPUT_FILES_ckb_inv/final_model.h5`
- 目标函数下降情况：`OUTPUT_FILES/OUTPUT_FILES_ckb_inv/objective_function.txt`

可使用 `Plot2_画检测板测试结果.ipynb` 画图展示检测板测试结果，以及目标函数下降情况。

#### 3. 真实数据反演

通过多次设计检测板，评估完数据的分辨能力之后，可以选择合适的反演网格尺寸，进行真实数据反演。

该反演包括两项流程：地震重定位，以及结构与震源联合反演。

第一步，地震重定位。
