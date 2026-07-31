# Checkerboard test

# If TomoATT was built from source, TomoATT_path should point to the generated
# executable, usually build/bin/TOMOATT.
# TomoATT_path=./bin/TOMOATT

# If TomoATT was installed with Conda, TOMOATT is usually available directly.
TomoATT_path=TOMOATT

# Number of MPI processes.
Nproc=8

# On WSL or in container-like environments, --allow-run-as-root may be needed.
# When using more processes than available slots, --oversubscribe may also be needed.

# Step 1: compute synthetic observations in the checkerboard model.
mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_ckb_signal.yaml

# Step 2: add zero-mean Gaussian noise to the synthetic checkerboard traveltimes.
python DataProc6_ckb_add_noise.py

# Step 3: invert the noisy checkerboard traveltimes.
# Run 10 iterations for this lightweight tutorial example.
mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_ckb_inv.yaml

# Run 80 iterations for a more complete checkerboard recovery.
# mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_ckb_inv_80iter.yaml
