import numpy as np
import time
from numba import njit, prange

# siatka - parametry
NX, NY = 300, 300
STEPS = 1000

DX = 10.0
DT = 0.001
VEL = 2000.0

coef = (VEL * DT / DX) ** 2

src_i = NX // 2
src_j = NY // 2

# numpy
def wave_numpy(n_steps):
    prev_field = np.zeros((NX, NY), dtype=np.float32)
    curr_field = np.zeros((NX, NY), dtype=np.float32)
    next_field = np.zeros((NX, NY), dtype=np.float32)

    for step in range(n_steps):

        if step < 20:
            curr_field[src_i, src_j] += 1.0

        next_field[1:-1, 1:-1] = (
            2.0 * (1.0 - 2.0 * coef) * curr_field[1:-1, 1:-1]
            - prev_field[1:-1, 1:-1]
            + coef * (
                curr_field[2:, 1:-1] +
                curr_field[:-2, 1:-1] +
                curr_field[1:-1, 2:] +
                curr_field[1:-1, :-2]
            )
        )

        next_field[0, :] = 0.0
        next_field[-1, :] = 0.0
        next_field[:, 0] = 0.0
        next_field[:, -1] = 0.0

        prev_field, curr_field, next_field = curr_field, next_field, prev_field

# numba
@njit(parallel=True)
def wave_numba(n_steps, c2, nx, ny, sx, sy):
    prev_field = np.zeros((nx, ny), dtype=np.float32)
    curr_field = np.zeros((nx, ny), dtype=np.float32)
    next_field = np.zeros((nx, ny), dtype=np.float32)

    for step in range(n_steps):

        if step < 20:
            curr_field[sx, sy] += 1.0

        for x in prange(1, nx - 1):
            for y in range(1, ny - 1):
                next_field[x, y] = (
                    2.0 * (1.0 - 2.0 * c2) * curr_field[x, y]
                    - prev_field[x, y]
                    + c2 * (
                        curr_field[x + 1, y] +
                        curr_field[x - 1, y] +
                        curr_field[x, y + 1] +
                        curr_field[x, y - 1]
                    )
                )

        for x in range(nx):
            next_field[x, 0] = 0.0
            next_field[x, ny - 1] = 0.0

        for y in range(ny):
            next_field[0, y] = 0.0
            next_field[nx - 1, y] = 0.0

        prev_field, curr_field, next_field = curr_field, next_field, prev_field


wave_numba(10, coef, NX, NY, src_i, src_j)

# pomiary czasu
start = time.perf_counter()
wave_numpy(STEPS)
end = time.perf_counter()
time_np = end - start

start = time.perf_counter()
wave_numba(STEPS, coef, NX, NY, src_i, src_j)
end = time.perf_counter()
time_nb = end - start


print("===== WYNIKI TESTU WYDAJNOSCI =====")
print(f"NumPy wykonanie: {time_np:.6f} s")
print(f"Numba wykonanie: {time_nb:.6f} s")
print(f"Wspolczynnik przyspieszenia: {time_np / time_nb:.2f}x")