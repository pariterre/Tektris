function cfg = terminateKinect(cfg)

    delete(cfg.h.depth);
    cfg.isStarted = false;
end