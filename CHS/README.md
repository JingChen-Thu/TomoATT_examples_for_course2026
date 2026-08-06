# 该示例的研究目标

该文件夹包括若干 TomoATT 成像示例，用于实现地震层析成像中的常见任务，包括：

1. 处理地震到时数据，适用于地震层析成像。
2. 设计检测板实验，确定数据分辨能力。
3. 开展真实数据近震走时层析成像与地震定位。
4. 结果绘图。

该示例使用的数据和成像流程参考论文：[Chen et al., 2026](https://doi.org/10.1038/s41561-025-01893-z). Chen, J., Xu, M., Bai, Y., Wu, S., Xiao, X., Hao, S., ... & Tong, P. (2026). High normal stress promoted supershear rupture during the 2023 Mw 7.8 Kahramanmaraş earthquake. Nature Geoscience, 1-8.

该示例源于 GitHub 仓库：[TomoATT_examples_for_course2026](https://github.com/JingChen-Thu/TomoATT_examples_for_course2026)。

## 引用方式

TomoATT 程序可以引用：

1. [Chen et al., 2025](https://doi.org/10.1016/j.cageo.2025.105995). Chen, J., Nagaso, M., Xu, M., & Tong, P. (2025). TomoATT: An open-source package for Eikonal equation-based adjoint-state traveltime tomography for seismic velocity and azimuthal anisotropy. Computers & Geosciences, 204, 105995.

近震成像方法可以引用：

1. [Tong, 2021a](https://doi.org/10.1029/2021JB021818). Tong, P. (2021). Adjoint-state traveltime tomography: Eikonal equation-based methods and application to the Anza area in southern California. Journal of Geophysical Research: Solid Earth, 126(5), e2021JB021818.
2. [Tong, 2021b](https://doi.org/10.1029/2021JB022365). Tong, P. (2021). Adjoint-state traveltime tomography for azimuthally anisotropic media and insight into the crustal structure of central California near Parkfield. Journal of Geophysical Research: Solid Earth, 126(10), e2021JB022365.
3. [Chen et al., 2023a](https://doi.org/10.1093/gji/ggad093)。Chen, J., Chen, G., Nagaso, M., & Tong, P. (2023). Adjoint-state traveltime tomography for azimuthally anisotropic media in spherical coordinates. Geophysical Journal International, 234(1), 712-736.

差分数据成像可以引用：

1. [Tong, 2023](https://doi.org/10.1093/gji/ggad416). Tong, P., Li, T., Chen, J., & Nagaso, M. (2024). Adjoint-state differential arrival time tomography. Geophysical Journal International, 236(1), 139-160.

远震成像方法可以引用：

1. [Chen et al., 2023b](https://doi.org/10.1029/2023JB027348). Chen, J., Wu, S., Xu, M., Nagaso, M., Yao, J., Wang, K., ... & Tong, P. (2023). Adjoint-state teleseismic traveltime tomography: method and application to Thailand in Indochina Peninsula. Journal of Geophysical Research: Solid Earth, 128(12), e2023JB027348.

## 一些有用的链接

- TomoATT 官网：[https://tomoatt.com](https://tomoatt.com)
- TomoATT 的 GitHub 仓库：[https://github.com/TomoATT/TomoATT](https://github.com/TomoATT/TomoATT)
- TomoATT 的文档：[https://tomoatt.com/docs](https://tomoatt.com/docs)
- TomoATT 的论坛：[https://github.com/orgs/TomoATT/discussions](https://github.com/orgs/TomoATT/discussions).（使用 TomoATT 时遇到任何问题，都可以在论坛提问，中文英文都可以，管理员会尽快回复。）


- PyTomoATT 的文档：[https://tomoatt.github.io/PyTomoATT/index.html](https://tomoatt.github.io/PyTomoATT/index.html)
- PyTomoATT 的 GitHub 仓库：[https://github.com/TomoATT/PyTomoATT](https://github.com/TomoATT/PyTomoATT)
- SurfATT 的文档：[https://tomoatt.com/surfdocs](https://tomoatt.com/surfdocs)
- SurfATT 的 GitHub 仓库：[https://github.com/TomoATT/SurfATT](https://github.com/TomoATT/SurfATT)

## 研究步骤

### 预备工作：程序安装

在命令行中执行：

```bash
mamba create -n tomoatt_conda
```

创建新的 conda 环境。然后切换到 conda 环境，并进行 TomoATT 和 PyTomoATT 的快捷安装：

```bash
mamba activate tomoatt_conda
mamba install tomoatt pytomoatt
```

其中，TomoATT 是基于 C++ 语言开发的成像软件，官网链接为 [https://tomoatt.com](https://tomoatt.com)。PyTomoATT 是 Python 模组，用于处理 TomoATT 的输入和输出文件，官网链接为 [PyTomoATT 文档](https://tomoatt.github.io/PyTomoATT/index.html)。

注释：

1. 如果没有 `mamba` 命令，WSL或Linux 可以按照如下方式安装 miniforge:
```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
bash Miniforge3-Linux-x86_64.sh
```
2. 如果没有 `mamba` 命令，但是安装过 conda 环境，可以将 `mamba`命令替换为 `conda`命令进行安装：
```bash
conda create -n tomoatt_conda
conda activate tomoatt_conda
conda install tomoatt pytomoatt
```
但是直接使用 `conda install tomoatt pytomoatt` 进行安装，等待时间可能会比较长。
3. 如果没有 `mamba` 命令，但是安装过 conda 环境，还可以直接使用 `conda` 安装 `mamba`：
```bash
conda install -c conda-forge mamba
```
然后就可以使用 `mamba` 命令了

安装完成之后，测试 TomoATT 的安装情况：

```bash
TOMOATT
```

若输出以下信息，则表示正常安装：

```bash
usage: mpirun -np 4 TOMOATT -i input_params.yaml
Error: input parameter file not found
```

更多种的安装方式，例如下载源码安装等，可以参考官方文档: [https://www.tomoatt.com/docs/GetStarted/Installation/Conda_Installation](https://www.tomoatt.com/docs/GetStarted/Installation/Conda_Installation)

测试 PyTomoATT 的安装情况：

```bash
pta -h
```

若输出以下信息，则表示正常安装：

```bash
usage: pta <command> [<args>]
...
```

### 第一步：走时数据处理

获得可靠走时数据是可靠反演的基础。进入数据处理目录 `Step1_Data_Process`：

```bash
cd Step1_Data_Process
```

该目录中提供了 5 个走时处理脚本，旨在保留研究区域内的可靠数据，删除研究区域外以及相对不可靠的数据。处理后的阶段文件均存储于 `output_data` 中，相关绘图存储于 `figs` 中。

具体步骤包括：


该数据文件 `traveltime_data/src_rec_Turkey.dat` 符合 TomoATT 数据文件格式。接下来，将对其中的数据进行筛选，以用于后续成像。

#### 1. 确定研究区域，并删除研究区域之外的地震

涉及脚本与数据文件：

- `DataProc1_remove_data_outside_study_region.ipynb`
- `traveltime_data/src_rec_Turkey.tar.gz`

该脚本用于确定研究区域，并删除研究区域之外的地震与台站。根据需要，研究区域可以进行旋转。输出文件包括：

- 旋转区域后的数据文件：`output_data/step1_src_rec_indom.dat`
- 原始区域的地震列表：`output_data/step1_ev_list.dat`
- 原始区域的台站列表：`output_data/step1_st_list.dat`
- 原始区域的数据文件：`output_data/step1_src_rec_data_norot.dat`

#### 2. 使用线性回归，删除残差较大的数据

涉及脚本与数据文件：

- `DataProc2_keep_reliable_data_by_linear_regression.ipynb`
- `output_data/step1_src_rec_indom.dat`

该脚本绘制震源距-首达走时散点图，并使用线性回归的方式删除误差较大的走时数据。输出文件包括：

- 筛选之后的数据文件：`output_data/step2_src_rec_remove_outlier.dat`

#### 3. 删除到时数量较少的地震

涉及脚本与数据文件：

- `DataProc3_remove_events_with_few_arrivals.ipynb`
- `output_data/step2_src_rec_remove_outlier.dat`

该脚本可用于删除到时少于特定数量的地震数据。当走时数据较少时，其震源参数难以准确约束，因此可删除。输出文件包括：

- 筛选之后的数据文件：`output_data/step3_src_rec_filtered.dat`

若用户对震源信息有把握，可以不进行删除。

#### 4. 基于绝对走时数据，生成差分到时

涉及脚本与数据文件：

- `DataProc4_generate_differential_arrival_times.ipynb`
- `output_data/step3_src_rec_filtered.dat`

该脚本可以基于绝对到时数据，按照一定的筛选原则生成共源差分到时数据或共台差分到时数据。输出文件包括：

- 加入共源差分数据的文件：`output_data/step4_src_rec_cs.dat`

其中，共源差分到时对震源不确定性不敏感，可用于提高成像可靠性；共台差分到时对台站附近结构不敏感，可用于提高震源相对定位精度以及提高震源附近结构成像分辨率。需要注意的是，共台差分到时更易受到震源不确定性影响，使用该数据需要尽量保证震源信息准确。

到该步骤之后，数据已经处理完备。将处理好的数据备份一份，存储于 `CHS/1_src_rec_files/src_rec_file.dat`，用于后续反演。

#### 5. 可选：给地震与台站赋予权重

涉及脚本与数据文件：

- `DataProc5_optional_set_data_weights.ipynb`
- `output_data/step4_src_rec_cs.dat`

该脚本可用于给地震与台站赋予权重，在数据分布不均匀的情况下，提升反演收敛速度，缩短收敛所需迭代次数。输出文件包括：

- 赋予权重的数据文件：`output_data/step5_src_rec_weight.dat`
- 地震权重文件：`step5_ev_list_weight.dat`
- 台站权重文件：`step5_st_list_weight.dat`

该示例反演流程没有添加数据权重，用户可根据实际需要进行添加。

#### 6. 数据文件处理部分结束

退出到主目录 `PATH/CHS`：

```bash
cd ..
```

### 第二步：构建反演初始模型

TomoATT 使用迭代法更新模型，因此反演需要提供合适的初始模型。

进入初始模型构造目录 `Step2_Initial_Model`：

```bash
cd Step2_Initial_Model
```

这里提供基于 Crust 1.0 模型生成一维层状模型的脚本。

涉及脚本：

- `ModelProc1_generate_initial_1d_model.ipynb`

该脚本会读取 TomoATT 参数文件 `../3_input_params/input_params_step1_1D_inv.yaml` 中的正演网格参数，并基于 Crust 1.0 模型生成一维模型。每个深度的速度取当前研究区域中 Crust 1.0 模型的平均速度。

输出模型文件：

- `output_model/model_1d_crust1.0_N31_61_31.h5`

同时，该模型文件也备份了一份到主目录 `PATH/CHS/2_models/model_1d_crust1.0_N31_61_31.h5`。

模型文件是 HDF5 格式，可以在命令行使用 `h5ls` 简单查看该文件中的内容，例如：

```bash
h5ls output_model/model_1d_crust1.0_N31_61_31.h5
```

输出为：

```bash
eta                      Dataset {31, 61, 31}
vel                      Dataset {31, 61, 31}
xi                       Dataset {31, 61, 31}
zeta                     Dataset {31, 61, 31}
```

其中，`vel` 表示速度，是三维数组，表示三维正演网格点上的速度值。深度方向（第一维）包括 31 个网格点，纬度方向（第二维）包括 61 个网格点，经度方向（第三维）包括 31 个网格点。类似的三维数组 `xi`、`eta` 表示方位角各向异性参数。`zeta` 目前暂时未实装。

另外，用户可根据需求参考更丰富的模型生成脚本，生成符合自己研究需求的模型。参考链接：[TomoATT HDF5 模型生成脚本](https://tomoatt.com/docs/Tools/scripts_of_generate_hdf5_model/introduction)。

模型生成完毕后，退出到主目录 `PATH/CHS`：

```bash
cd ..
```

### 第三步：初始一维模型反演

在第二步中，我们初步构建了适用于 TomoATT 程序的模型文件，然而，该模型可能并不合适。这里“合适的模型”的具体含义是：在该模型下，理论走时和观测走时的残差均值应该在 0 附近，例如其绝对值小于 0.1 秒。

只有走时残差均值在 0 附近，其模型整体速度才没有偏高或者偏低。否则，在后续迭代中，程序会优先恢复速度均值，导致成像结果相对初始模型的扰动整体为正值或负值。不能说这种整体偏高或者偏低的初始模型无法得到好的成像结果，而是会增加反演收敛到局部极小的风险。

地震层析成像本身是一个病态问题，其反演问题通常是多解的。一个合适的模型有助于收敛到更加符合实际的模型。因此，该步骤旨在获得合适的初始模型用于地震层析成像，保证初始模型能够尽量满足走时残差均值在 0 附近。

注释：

1. 速度模型和地震位置都会影响走时残差，两者相互耦合。通常我们需要倾向于相信其中一个。例如这里我们倾向于相信震源位置，因此需要更新初始模型，使走时残差更新到 0 附近。若初始构造模型来源于可靠性较高的区域模型，可以倾向于相信模型，从而进行震源初步重定位，使走时残差更新到 0 附近。
2. 在一些测试中，我们发现成像结果对初始模型的依赖并不强，差异较大的初始模型仍然能够得到一致的反演结果。这种情况通常对地震数据质量和分布有较高要求。

在命令行中使用以下命令，通过 TomoATT 进行一维速度模型反演：

```bash
bash Step3_bash_1d_model_inversion.sh
```

该反演使用以下文件：

- 数据文件：`./1_src_rec_files/src_rec_file.dat`
- 模型文件：`./2_models/model_1d_crust1.0_N31_61_31.h5`
- 参数文件：`./3_input_params/input_params_step1_1D_inv.yaml`

使用命令：

```bash
mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_step1_1D_inv.yaml
```

反演结果存储在目录 `OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv` 中，重要的输出文件包括：

- 最终模型文件：`OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5`
- 目标函数下降情况：`OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/objective_function.txt`

输出的模型文件也备份了一份到 `2_models/model_1d_after_1d_inv.h5`。

可使用 `Plot1_plot_1d_model_inversion_results.ipynb` 画图展示反演前后的一维模型、目标函数下降曲线、和走时残差分布。图片输出到 
- 一维模型：`figs/Step3_id_model_inv.png`
- 目标函数下降曲线：`figs/Step3_objective_function_reduction.png`
- 走时残差分布：`Step3_residual.png`

### 第四步：开展检测板测试

设计检测板测试旨在评估当前地震数据对速度结构与各向异性的分辨能力。

#### 1. 构造检测板模型

首先需要构造检测板模型。进入目录 `Step4_ckb_model`：

```bash
cd Step4_ckb_model
```

使用 `ModelProc2_generate_checkerboard_model.ipynb`，基于反演得到的一维模型文件 `OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5` 添加高低速异常以及各向异性异常，构建检测板模型。

这里速度异常的尺寸是 1° × 1° × 10 km，各向异性异常是 1.5° × 1.5° × 10 km。对应参数文件中的反演网格尺寸设置为 0.5° × 0.5° × 5 km（速度）和 0.75° × 0.75° × 5 km（各向异性）。

反演网格的设置是层析成像的核心之一，同时非常依赖于检测板测试的情况。这里给出一些注释：

1. 各向异性的反演难度要高于速度结构，因此，通常最优的速度结构分辨率会高于各向异性分辨率。因此，在设计检测板时，速度异常的尺寸会更小一些。
2. 反演网格的最优恢复能力是 2 倍的反演网格尺寸。逻辑是检测板中，两个相邻的高低速异常块可用 `sin` 函数近似，正值表示高速异常，负值表示低速异常，可以被 5 个反演网格点控制：零点 `x = 0`，波峰 `x = pi/2`，零点 `x = pi`，波谷 `x = 3pi/2`，零点 `x = 2pi`。此时，反演网格点的间距就是异常体尺寸的一半。
3. 反演程序的极限分辨能力由反演网格尺寸决定：越细的反演网格具有越高的分辨能力，即能分辨越小尺寸的异常体。但是，在数据有限的条件下，稀疏的数据无法有效约束太细的结构，从而导致伪影或虚假异常。因此，反演网格又不能太细。在测试过程中，通常需要设计若干套具有不同异常体尺寸大小的检测板，用于评估测试数据的恢复能力。

模型文件存储到 `output_model/model_ckb_N31_61_31.h5`，同时备份到主目录 `PATH/CHS/2_models/model_ckb_N31_61_31.h5`。

检测板模型图像存储为 `figs/ModelProc2_ckb_model.png`。

退出到主目录 `PATH/CHS`：

```bash
cd ..
```

#### 2. 检测板测试

在命令行中使用以下命令，执行检测板测试：

```bash
bash Step4_bash_checkerboard_test.sh
```

检测板测试包括三项步骤：

##### 第一步：计算检测板模型下的观测到时

计算检测板模型下的观测到时，得到检测板测试中的观测信号。该正演使用以下文件：

- 数据文件：`1_src_rec_files/src_rec_file.dat`
- 模型文件：`2_models/model_ckb_N31_61_31.h5`
- 参数文件：`3_input_params/input_params_ckb_signal.yaml`

使用命令：

```bash
mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_ckb_signal.yaml
```

正演得到的信号文件保存在：

- 检测板观测到时：`OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward.dat`

##### 第二步：给观测信号添加高斯噪声

使用以下 Python 脚本给观测信号添加高斯噪声：

- `DataProc6_ckb_add_noise.py`

处理得到的噪声数据保存在：

- 添加噪声的数据文件：`OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward_noisy.dat`

注释：这里默认给观测绝对走时添加均值为 0、标准差为 0.1 秒的高斯噪声。差分走时仍然由绝对走时相减得到。这里默认的 0.1 秒认为是手挑到时的误差范围。具体噪声强度可根据实际情况进行选择。

##### 第三步：使用添加噪声后的走时数据进行反演

从没有异常的初始模型出发，尝试恢复检测板异常体。该反演使用以下文件：

- 数据文件：`OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward_noisy.dat`
- 模型文件：`OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5`
- 参数文件：`3_input_params/input_params_ckb_inv.yaml`

使用命令：

```bash
mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_ckb_inv.yaml
```

该示例仅进行 10 次迭代，用于示例，因此异常体恢复效果一般。反演结果存储在目录 `OUTPUT_FILES/OUTPUT_FILES_ckb_inv` 中，重要的输出文件包括：

- 最终模型文件：`OUTPUT_FILES/OUTPUT_FILES_ckb_inv/final_model.h5`
- 目标函数下降情况：`OUTPUT_FILES/OUTPUT_FILES_ckb_inv/objective_function.txt`

若要进行完整 80 次迭代，可使用参数文件 `3_input_params/input_params_ckb_inv_80iter.yaml`，异常体恢复效果更好。反演结果将会存储在 `OUTPUT_FILES/OUTPUT_FILES_ckb_inv_80iter` 中。

为了进行验证，80 次迭代模型打包在目录 `PATH/CHS/benchmark_dataset/OUTPUT_FILES_ckb_inv_80iter/final_model.h5` 中。

可使用 `Plot2_plot_checkerboard_test_results.ipynb` 画图展示检测板测试结果。图片存储路径为 `figs/Step4_ckb_inv.png`。

### 第五步：真实数据反演

使用检测板测试确定合适的反演网格设置后，可以进行真实数据层析成像，反演地下速度结构与各向异性。

在命令行中使用以下命令，执行真实数据成像：

```bash
bash Step5_bash_real_data_inversion.sh
```

真实数据成像包括两项步骤：

#### 1. 地震初步重定位

为了降低初始震源误差的影响，避免震源误差显著影响成像结果，需要在初始模型下对震源位置进行初步更新。该反演使用以下文件：

- 数据文件：`./1_src_rec_files/src_rec_file.dat`
- 模型文件：`OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5`
- 参数文件：`./3_input_params/input_params_step2_reloc.yaml`

使用命令：

```bash
mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_step2_reloc.yaml
```

使用迭代法更新震源位置与发震时刻，进行 30 次迭代。反演结果存储在目录 `OUTPUT_FILES/OUTPUT_FILES_step2_reloc` 中，重要的输出文件包括：

- 目标函数下降情况：`OUTPUT_FILES/OUTPUT_FILES_step2_reloc/objective_function.txt`
- 更新震源之后的观测走时数据：`src_rec_file_reloc_0030_obs.dat`
- 更新震源之后的理论走时数据：`src_rec_file_reloc_0030.dat`

注释：

1. 更新震源之后，观测走时数据会发生更新，即输入观测走时 `./1_src_rec_files/src_rec_file.dat` 和新观测走时 `src_rec_file_reloc_0030_obs.dat` 不相同，在震源位置、发震时刻和台站走时上均不同。震源位置和发震时刻不同是自然的，因为震源信息进行了更新。台站走时变化，是因为发震时刻发生了变化。显然，观测到时是挑出来的，这个绝对时刻是固定不变的。当地震的发震时刻提前了 `t` 秒时，所有关于这个地震的走时自然就增加了 `t` 秒。因此，观测走时会发生变化。
2. 根据注释 1，当我们要使用更新震源之后的结果进行后续反演时，需要使用更新之后的数据文件。

#### 2. 速度结构、各向异性、震源信息联合反演

最后进行三种参数，即速度结构、各向异性、震源信息的联合反演。该反演使用以下文件：

- 数据文件：`OUTPUT_FILES/OUTPUT_FILES_step2_reloc/src_rec_file_reloc_0030_obs.dat`
- 模型文件：`OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5`
- 参数文件：`./3_input_params/input_params_step3_inv_reloc.yaml`

使用命令：

```bash
mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_step3_inv_reloc.yaml
```

该示例仅进行 10 次迭代，用于示例，因此异常体恢复效果一般。反演结果存储在目录 `OUTPUT_FILES/OUTPUT_FILES_step3_inv_reloc` 中，重要的输出文件包括：

- 最终模型文件：`OUTPUT_FILES/OUTPUT_FILES_step3_inv_reloc/final_model.h5`
- 目标函数下降情况：`OUTPUT_FILES/OUTPUT_FILES_step3_inv_reloc/objective_function.txt`

若要进行完整 100 次迭代，可使用参数文件 `3_input_params/input_params_step3_inv_reloc_100iter.yaml`，异常体恢复效果更好。反演结果将会存储在 `OUTPUT_FILES/OUTPUT_FILES_step3_inv_reloc_100iter` 中。

为了进行验证，100 次迭代模型打包在目录 `PATH/CHS/benchmark_dataset/OUTPUT_FILES_step3_inv_reloc_100iter/final_model.h5` 中。

可使用 `Plot3_plot_real_data_inversion_results.ipynb` 画图展示真实数据层析成像结果。图片存储路径为 `figs/Step5_real_inv.png`。

注释：
1. TomoATT 使用迭代法更新参数：在第 `k` 步迭代结果中，计算目标函数关于速度结构、各向异性、震源位置与发震时刻的梯度，同时更新以上参数，得到第 `k + 1` 步迭代结果。总计进行 100 次迭代。
2. 默认采用最速下降法更新速度结构与各向异性，其梯度会归一化，并在每步迭代中使用最大下降步长进行控制。默认的初始步长是 2% 的扰动量。
3. 地震定位也采用最速下降法，更新每个震源的位置与发震时刻。其梯度同样会归一化，并使用独立于结构的最大下降步长进行控制。默认是每次最大变化 `0.05 km / 0.05 km / 0.05 km / 0.008 s`。
4. 在地震重定位之后，仍然需要在结构更新时同步更新震源。这是因为之前地震重定位得到的是层状模型下的合适震源位置。但是当成像迭代中模型发生更新时，震源不再是合适的震源位置，需要随着模型更新而变化。同时，考虑到每步迭代的模型变化量并不大，因此每步迭代的震源位置更新量同样采用了较为保守的数值。

