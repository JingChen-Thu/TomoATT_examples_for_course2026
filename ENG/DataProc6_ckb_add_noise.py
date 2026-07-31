# Add zero-mean Gaussian noise to synthetic checkerboard traveltimes,
# mimicking picking errors in real data.

from pytomoatt.src_rec import SrcRec


def assign_noise_to_src_rec_file(in_fname, out_fname, noise_level=0.1):
    sr = SrcRec.read(in_fname)
    sr.add_noise(noise_level)
    sr.write(out_fname)


if __name__ == "__main__":
    in_fname = "OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward.dat"
    out_fname = "OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward_noisy.dat"
    # sigma = 0.0 means no added noise.
    sigma = 0.1  # Standard deviation of Gaussian noise, in seconds.
    assign_noise_to_src_rec_file(in_fname, out_fname, noise_level=sigma)
