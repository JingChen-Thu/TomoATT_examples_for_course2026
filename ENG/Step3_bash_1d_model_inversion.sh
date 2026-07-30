# 1-D model inversion

# If TomoATT was built from source, TomoATT_path should point to the generated
# executable, usually build/bin/TOMOATT.
# TomoATT_path=../../build/bin/TOMOATT

# If TomoATT was installed with Conda, TOMOATT is usually available directly.
TomoATT_path=TOMOATT

# Number of MPI processes.
Nproc=8

# On WSL or in container-like environments, --allow-run-as-root may be needed.
# When using more processes than available slots, --oversubscribe may also be needed.
mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_step1_1D_inv.yaml

# Back up the generated final model to the main example directory.
cp ./OUTPUT_FILES/OUTPUT_FILES_step1_1D_inv/final_model.h5 ./2_models/model_1d_after_1d_inv.h5
