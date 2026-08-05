# 检测板测试

# 如果使用源码安装的方式，TomoATT_path 需要指向生成的可执行文件 build/bin/TOMOATT 的路径
# TomoATT_path=../../build/bin/TOMOATT
# 若使用 Conda 安装的方式，则直接使用 TOMOATT 即可
TomoATT_path=TOMOATT

# 并行的processor数量
Nproc=8

# ------- 第一步，计算检测板模型下的观测到时 --------
mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_ckb_signal.yaml

# ------- 第二步，给检测板测试计算的合成走时添加均值为0的高斯噪声，模拟实际数据中的 picking error --------
python DataProc6_ckb_add_noise.py

# ------- 第三步，使用添加噪声后的走时数据进行反演 --------
# 进行10次迭代进行示例
mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_ckb_inv.yaml
# 进行80次迭代，得到完整结果
# mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_ckb_inv_80iter.yaml

# # 对于WSL系统，当用root用户运行时，需要添加 --allow-run-as-root
# # 当Nproc大于物理核心数时，需要 --oversubscribe 
# # ------- 第一步，计算检测板模型下的观测到时 --------
# mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_ckb_signal.yaml

# # ------- 第二步，给检测板测试计算的合成走时添加均值为0的高斯噪声，模拟实际数据中的 picking error --------
# python DataProc6_ckb_add_noise.py


# # ------- 第三步，使用添加噪声后的走时数据进行反演 --------
# # 进行10次迭代进行示例
# mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_ckb_inv.yaml
# # 进行80次迭代，得到完整结果
# # mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_ckb_inv_80iter.yaml
