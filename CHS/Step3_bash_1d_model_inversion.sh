# 一维模型反演

# 如果使用源码安装的方式，TomoATT_path 需要指向生成的可执行文件 build/bin/TOMOATT 的路径
# TomoATT_path=../../build/bin/TOMOATT
# 若使用 Conda 安装的方式，则直接使用 TOMOATT 即可
TomoATT_path=TOMOATT

# 并行的processor数量
Nproc=8

mpirun -n ${Nproc} ${TomoATT_path} -i 3_input_params/input_params_step1_1D_inv.yaml

# 对于WSL系统，当用root用户运行时，需要添加 --allow-run-as-root
# 当Nproc大于物理核心数时，需要 --oversubscribe 
# mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_step1_1D_inv.yaml

# 将生成的模型文件备份一份到主目录
cp ./OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5 ./2_models/model_1d_after_1d_inv.h5