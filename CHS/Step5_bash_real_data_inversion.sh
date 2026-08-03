# 检测板测试

# 如果使用源码安装的方式，TomoATT_path 需要指向生成的可执行文件 build/bin/TOMOATT 的路径
# TomoATT_path=./bin/TOMOATT
# 若使用 Conda 安装的方式，则直接使用 TOMOATT 即可
TomoATT_path=TOMOATT

# 并行的processor数量
Nproc=8

# 对于WSL系统，当用root用户运行时，需要添加 --allow-run-as-root
# 当Nproc大于物理核心数时，需要 --oversubscribe 
# ------- 第一步，地震重定位 --------
mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_step2_reloc.yaml

# ------- 第二步，各向异性速度反演+地震定位 --------
# 进行10次迭代进行示例
mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_step3_inv_reloc.yaml
# 进行100次迭代，得到完整结果
# mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_step3_inv_reloc_iter100.yaml
