# 一维模型反演

# 如果使用源码安装的方式，TomoATT_path 需要指向生成的可执行文件 build/bin/TOMOATT 的路径
TomoATT_path=../../build/bin/TOMOATT
Nproc=8


# 如果是使用源码安装
# 对于WSL系统，有时需要添加 --allow-run-as-root， 当使用较多的processor的时候，有时候需要 --oversubscribe 参数
mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_step1_1D_inv.yaml

# # 如果使用Conda安装的方式，可直接使用
# mpirun -n ${Nproc} TomoATT -i 3_input_params/input_params_step1_1D_inv.yaml