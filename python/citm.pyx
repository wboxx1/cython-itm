cimport cython
import numpy as np
cimport numpy as np
from cpython cimport array
from libc.stdlib cimport malloc, free
# from libcpp.vector import vector

# from citm cimport ITM_P2P_TLS
cdef extern from "..\\include\\itm.h":
    struct IntermediateValues:
        double[2] theta_hzn
        double[2] d_hzn__meter
        double[2] h_e__meter
        double N_s
        double delta_h__meter
        double A_ref__db
        double A_fs__db
        double d__km
        int mode

    int ITM_P2P_TLS(double h_tx__meter, double h_rx__meter, double[] pfl, int climate, double N_0, double f__mhz,
        int pol, double epsilon, double sigma, int mdvar, double time, double location, double situation,
        double *A__db, long *warnings)

    int ITM_P2P_TLS_Ex(double h_tx__meter, double h_rx__meter, double[] pfl, int climate, double N_0, double f__mhz,
        int pol, double epsilon, double sigma, int mdvar, double time, double location, double situation,
        double *A__db, long *warnings, IntermediateValues *interValues)

    int ITM_P2P_CR(double h_tx__meter, double h_rx__meter, double[] pfl, int climate, double N_0, double f__mhz,
        int pol, double epsilon, double sigma, int mdvar, double confidence, double reliability,
        double *A__db, long *warnings)

    int ITM_P2P_CR_Ex(double h_tx__meter, double h_rx__meter, double[] pfl, int climate, double N_0, double f__mhz,
        int pol, double epsilon, double sigma, int mdvar, double confidence, double reliability,
        double *A__db, long *warnings, IntermediateValues *interValues)

cdef class ITM:
    cdef IntermediateValues intermediate_values
    cdef double h_tx__meter
    cdef double h_rx__meter
    cdef double* pfl
    cdef int climate
    cdef double N_0
    cdef double f__mhz
    cdef int pol
    cdef double epsilon
    cdef double sigma
    cdef int mdvar
    cdef double time
    cdef double location
    cdef double situation 
    cdef double[:] A__db
    cdef long long[:] warnings

    @property
    def A__db(self):
        return np.asarray(self.A__db)[0]

    @property
    def warnings(self):
        return hex(np.asarray(self.warnings)[0])

    @property
    def theta_hzn(self):
        return self.intermediate_values.theta_hzn

    @property
    def d_hzn__meter(self):
        return self.intermediate_values.d_hzn__meter

    @property
    def h_e__meter(self):
        return self.intermediate_values.h_e__meter

    @property
    def N_s(self):
        return self.intermediate_values.N_s

    @property
    def delta_h__meter(self):
        return self.intermediate_values.delta_h__meter

    @property
    def A_ref__db(self):
        return self.intermediate_values.A_ref__db

    @property
    def A_fs__db(self):
        return self.intermediate_values.A_fs__db

    @property
    def d__km(self):
        return self.intermediate_values.d__km

    @property
    def mode(self):
        return self.intermediate_values.mode

    def __cinit__(
        self,
        double h_tx__meter, double h_rx__meter,
        np.ndarray[np.double_t, ndim=1] pfl,
        int climate, double N_0, double f__mhz, 
        int pol, double epsilon, double sigma,
        int mdvar
    ):
        self.h_tx__meter = h_tx__meter
        self.h_rx__meter = h_rx__meter
        self.pfl = <double*> pfl.data
        self.climate = climate
        self.N_0 = N_0
        self.f__mhz = f__mhz
        self.pol = pol
        self.epsilon = epsilon
        self.sigma = sigma
        self.mdvar = mdvar
        cdef np.ndarray[np.double_t, ndim=1] a__db = np.ndarray((1,))
        self.A__db = a__db
        cdef np.ndarray[np.long_t, ndim=1] warnings = np.ndarray((1,), dtype=np.int64)
        self.warnings = warnings

    # cdef int itm_p2p_tls_invoke(double h_tx__meter, double h_rx__meter, np.ndarray[np.double_t, ndim=1] pfl, int climate, double N_0, double f__mhz,
    #     int pol, double epsilon, double sigma, int mdvar, double time, double location, double situation,
    #     np.ndarray[np.double_t, ndim=1] A__db, np.ndarray[np.long_t, ndim=1] warnings):
    #     return ITM_P2P_TLS(h_tx__meter=h_tx__meter, h_rx__meter=h_rx__meter, pfl=pfl, climate=climate, N_0=N_0,
    #         f__mhz=f__mhz, pol=pol, epsilon=epsilon, sigma=sigma, mdvar=mdvar, time=time, location=location,
    #         situation=situation, A__db=A__db, warnings=warnings)

    # cdef get_A__db():
    #     cdef np.ndarray[np.double_t, ndim=1] a__db
    #     return a__db

    # cdef get_warnings():
    #     cdef np.ndarray[np.long_t, ndim=1] warnings
    #     return warnings

    def itm_p2p_tls(
        self,
        double time, double location, double situation, 
    ):
        cdef np.ndarray[np.double_t, ndim=1] A__db = np.ndarray((1,), dtype=np.double)
        cdef np.ndarray[np.long_t, ndim=1] warnings = np.ndarray((1,), dtype=np.int64)
        
        return_val =  ITM_P2P_TLS_Ex(
            h_tx__meter=self.h_tx__meter, h_rx__meter=self.h_rx__meter,
            pfl= self.pfl, climate=self.climate, N_0=self.N_0,
            f__mhz=self.f__mhz, pol=self.pol, epsilon=self.epsilon, sigma=self.sigma,
            mdvar=self.mdvar, time=time, location=location, situation=situation,
            A__db=<double*> A__db.data, warnings=<long*> warnings.data,
            interValues=&self.intermediate_values
        )
        self.A__db = A__db
        self.warnings = warnings
        return return_val

    # def itm_p2p_tls_ex(
    #     self,
    #     double time, double location, double situation, 
    # ):
    #     return_val =  ITM_P2P_TLS_Ex(
    #         h_tx__meter=h_tx__meter, h_rx__meter=h_rx__meter,
    #         pfl=<double*> pfl.data, climate=climate, N_0=N_0,
    #         f__mhz=f__mhz, pol=pol, epsilon=epsilon, sigma=sigma,
    #         mdvar=mdvar, time=time, location=location, situation=situation,
    #         A__db=<double*> A__db.data, warnings=<long*> warnings.data,
    #         interValues=&self.intermediate_values
    #     )
    #     return return_val

    def itm_p2p_cr(
        self,
        double confidence, double reliability
    ):
        cdef np.ndarray[np.double_t, ndim=1] A__db = np.ndarray((1,), dtype=np.double)
        cdef np.ndarray[np.long_t, ndim=1] warnings = np.ndarray((1,), dtype=np.int64)

        return_val = ITM_P2P_CR_Ex(
            h_tx__meter=self.h_tx__meter, h_rx__meter=self.h_rx__meter,
            pfl=self.pfl, climate=self.climate, N_0=self.N_0, f__mhz=self.f__mhz,
            pol=self.pol, epsilon=self.epsilon, sigma=self.sigma, mdvar=self.mdvar,
            confidence=confidence, reliability=reliability,
            A__db=<double*> A__db.data, warnings=<long*> warnings.data,
            interValues=&self.intermediate_values
        )
        self.A__db = A__db
        self.warnings = warnings
        return return_val
