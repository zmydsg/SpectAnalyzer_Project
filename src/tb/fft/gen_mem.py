import numpy as np

N = 8
x = np.array([ 0.8,  0.7, -0.2,  0.1,
              -0.5,  0.3,  0.9, -1.0], dtype=np.float64)

S = 2**15 - 1
x_q15 = np.int16(np.round(np.clip(x * S, -32768, 32767)))

X = np.fft.fft(x_q15.astype(np.float64))
mag2 = np.round((np.abs(X)**2) / S**2 * S).astype(np.int16)

with open("golden.mem", "w") as f:
    for v in mag2:
        f.write(f"{(v & 0xFFFF):04x}\n")