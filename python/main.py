# import os
# import pathlib

# libdir = str(pathlib.Path("..\\include\\").absolute())

# os.add_dll_directory(libdir)

from py_itm import ITM

h_tx__meter = 10
h_rx__meter = 10
pfl = [10, 100, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
climate = 5
N_0 = 301
f__mhz = 2000
pol = 1
epsilon = 15
sigma = 0.008
time = 90
location = 95
situation = 90
mdvar = 12
A__db = []
warnings = []

print(
    ITM.my_itm_p2p_tls(
        h_tx__meter,
        h_rx__meter,
        pfl,
        climate,
        N_0,
        f__mhz,
        pol,
        epsilon,
        sigma,
        mdvar,
        time,
        location,
        situation,
        A__db,
        warnings,
    )
)
