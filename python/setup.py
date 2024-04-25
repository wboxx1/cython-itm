import numpy
from Cython.Build import cythonize
from setuptools import Extension, setup

ext_modules = [
    Extension(
        "py_itm",
        [
            "citm.pyx",
            "..\\src\\ComputeDeltaH.cpp",
            "..\\src\\DiffractionLoss.cpp",
            "..\\src\\FindHorizons.cpp",
            "..\\src\\FreeSpaceLoss.cpp",
            "..\\src\\FresnelIntegral.cpp",
            "..\\src\\H0Function.cpp",
            "..\\src\\InitializeArea.cpp",
            "..\\src\\InitializePointToPoint.cpp",
            "..\\src\\InverseComplementaryCumulativeDistributionFunction.cpp",
            "..\\src\\itm_area.cpp",
            "..\\src\\itm_p2p.cpp",
            "..\\src\\KnifeEdgeDiffraction.cpp",
            "..\\src\\LinearLeastSquaresFit.cpp",
            "..\\src\\LineOfSightLoss.cpp",
            "..\\src\\LongleyRice.cpp",
            "..\\src\\QuickPfl.cpp",
            "..\\src\\SigmaHFunction.cpp",
            "..\\src\\SmoothEarthDiffraction.cpp",
            "..\\src\\TerrainRoughness.cpp",
            "..\\src\\TroposcatterLoss.cpp",
            "..\\src\\ValidateInputs.cpp",
            "..\\src\\Variability.cpp",
        ],
        include_dirs=["..\\include", numpy.get_include()],
        language="c++",
    )
]

setup(name="py_itm", ext_modules=cythonize(ext_modules))

# ext_modules = [
#     Extension(
#         "py_itm",
#         ["citm.pyx"],
#         libraries=["itm"],
#         library_dirs=["..\\include"],
#         include_dirs=["..\\include"],
#         language="c++",
#     )
# ]
