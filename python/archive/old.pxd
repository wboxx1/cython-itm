cdef extern from "..\\include\\itm.h":
        
    int ITM_P2P_TLS(double h_tx__meter, double h_rx__meter, double[2] pfl, int climate, double N_0, double f__mhz,
        int pol, double epsilon, double sigma, int mdvar, double time, double location, double situation,
        double *A__db, long *warnings)

    int ITM_P2P_CR(double h_tx__meter, double h_rx__meter, double[] pfl, int climate, double N_0, double f__mhz,
        int pol, double epsilon, double sigma, int mdvar, double confidence, double reliability,
        double *A__db, long *warnings)