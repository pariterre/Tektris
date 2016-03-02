function cfg = initiateKinect(cfg)
    % Restart de la toolbox
    imaqreset

    % D�marrer les kinect
    %cfg.kinect.h.video = videoinput('kinect',1); % Vid�o
    cfg.kinect.h.depth = videoinput('kinect',2); % Cam�ra de profondeur

    % D�marrer le tracking du skelette
    set(getselectedsource(cfg.kinect.h.depth), 'TrackingMode', 'Skeleton');

    % Configuration du trigger
    triggerconfig(cfg.kinect.h.depth,'manual');
    cfg.kinect.h.depth.FramesPerTrigger = 1;
    cfg.kinect.h.depth.TriggerRepeat = inf;

    start(cfg.kinect.h.depth);
    
    % Lancer l'acquisition
    cfg.kinect.isStarted = true;

    % Maping utile lors de la repr�sentation vid�o
    cfg.kinect.SkeletonConnectionMap = [1 2 3 4 3 5 6 7 8 7 6 5 3 9 10 11 12 11 10 9 3 2 1 17 18 19 20 19 18 17 1 13 14 15 16 15 14 13 1];


end