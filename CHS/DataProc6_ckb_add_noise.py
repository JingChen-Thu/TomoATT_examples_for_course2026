# 该脚本给检测板测试计算的合成走时添加均值为0的高斯噪声，模拟实际数据中的 picking error

from pytomoatt.src_rec import SrcRec

def assign_noise_to_src_rec_file(in_fname, out_fname, noise_level=0.1):
    sr = SrcRec.read(in_fname)
    sr.add_noise(noise_level)
    sr.write(out_fname)


if __name__ == "__main__":
    in_fname = "OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward.dat" # input source receiver file
    out_fname = "OUTPUT_FILES/OUTPUT_FILES_ckb_signal/src_rec_file_forward_noisy.dat" # output source receiver file
    sigma = 0.0 # 噪声强度 sigma=0.0 表示不添加噪声
    # sigma = 0.1 # 噪声强度，sigma=0.1 表示高斯噪声的标准差为 0.1秒。 noise level in seconds
    assign_noise_to_src_rec_file(in_fname, out_fname, noise_level=sigma)
