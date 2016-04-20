function [cfg, output] = initiateWii(cfg)
    try
        cfg.WiiFit=Wiimote();		% Debug
        cfg.WiiFit.Connect();		% Debug
    catch
        errordlg('Connexion to Wii balance board has failed. Please make sure WiiLab installation script has been run and and make sure it appears in bluetooth devices!','ERREUR','modal')
        output = -1;
        return;
    end
    
    if cfg.WiiFit.isConnected == -1
        errordlg('Connexion to Wii balance board has failed. Please make sure WiiLab installation script has been run and and make sure it appears in bluetooth devices!','ERREUR','modal')
        output = -2;
        return;
    end
    
    output = 1;
end