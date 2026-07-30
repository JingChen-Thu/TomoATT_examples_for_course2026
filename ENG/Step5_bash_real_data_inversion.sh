# Real-data inversion

# If TomoATT was built from source, TomoATT_path should point to the generated
# executable, usually build/bin/TOMOATT.
# TomoATT_path=../../build/bin/TOMOATT

# If TomoATT was installed with Conda, TOMOATT is usually available directly.
TomoATT_path=TOMOATT

# Number of MPI processes.
Nproc=8

# On WSL or in container-like environments, --allow-run-as-root may be needed.
# When using more processes than available slots, --oversubscribe may also be needed.

# Step 1: preliminary earthquake relocation.
mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_step2_reloc.yaml

# Step 2: joint inversion for velocity, azimuthal anisotropy, and earthquake parameters.
# Run 10 iterations for this lightweight tutorial example.
mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_step3_inv_reloc.yaml

# Run 100 iterations for a more complete real-data inversion.
# mpirun -n ${Nproc} --allow-run-as-root --oversubscribe ${TomoATT_path} -i 3_input_params/input_params_step3_inv_reloc_100iter.yaml
