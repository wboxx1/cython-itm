from Cython.Build import cythonize
from setuptools import Extension, setup

ext_modules = [
    Extension(
        "itm",
        ["citm.pyx"],
        libraries=["..\\bin\\x64\\Release\\itm"],
        library_dirs=["..\\bin\\x64\\Release"],
        include_dirs=["..\\include"],
        language="c++",
    )
]

setup(name="itm", ext_modules=cythonize(ext_modules))
