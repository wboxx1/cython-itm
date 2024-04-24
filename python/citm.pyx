from cpython cimport array
# from citm cimport ITM_P2P_TLS
cdef extern from "..\\include\\itm.h":
    cdef int ITM_P2P_TLS(double h_tx__meter, double h_rx__meter, double[2] pfl, int climate, double N_0, double f__mhz,
        int pol, double epsilon, double sigma, int mdvar, double time, double location, double situation,
        double *A__db, long *warnings)

    cdef int ITM_P2P_CR(double h_tx__meter, double h_rx__meter, double[] pfl, int climate, double N_0, double f__mhz,
        int pol, double epsilon, double sigma, int mdvar, double confidence, double reliability,
        double *A__db, long *warnings)

    cpdef my_itm_p2p_tls(h_tx__meter, h_rx__meter, pfl, climate, N_0, f__mhz, pol, epsilon, sigma, mdvar, time,
        location, situation, A__db, warnings):
        cdef double _h_tx__meter = h_tx__meter
        cdef double _h_rx__meter = h_rx__meter
        # cdef array.array _pfl = array.array('d', pfl)
        cdef double[2] _pfl = pfl
        cdef int _climate = climate
        cdef double _N_0 = N_0
        cdef double _f__mhz = f__mhz
        cdef int _pol = pol
        cdef double _epsilon = epsilon
        cdef double _sigma = sigma
        cdef int _mdvar = mdvar
        cdef double _time = time
        cdef double _location = location
        cdef double _situation = situation
        # cdef double[1] _A__db = A__db
        cdef array.array _A__db = array.array('d', A__db)
        # cdef long[1] _warnings = warnings
        cdef array.array _warnings = array.array('l', warnings)
        return ITM_P2P_TLS(h_tx__meter=_h_tx__meter, h_rx__meter=_h_rx__meter, pfl=_pfl, climate=_climate, N_0=_N_0,
            f__mhz=_f__mhz, pol=_pol, epsilon=_epsilon, sigma=_sigma, mdvar=_mdvar, time=_time, location=_location,
            situation=_situation, A__db=_A__db.data.as_doubles, warnings=_warnings.data.as_longs)
# cpdef _itm_p2p_cr():
#     return ITM_P2P_CR