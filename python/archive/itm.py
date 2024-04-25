from . import citm


def _itm_p2p_tls(
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
):
    return citm.ITM_P2P_TLS(
        h_tx__meter=h_tx__meter,
        h_rx__meter=h_rx__meter,
        pfl=pfl,
        climate=climate,
        N_0=N_0,
        f__mhz=f__mhz,
        pol=pol,
        epsilon=epsilon,
        sigma=sigma,
        mdvar=mdvar,
        time=time,
        location=location,
        situation=situation,
        A__db=A__db,
        warnings=warnings,
    )
