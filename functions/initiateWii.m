function cfg = initiateWii(cfg)
    try
        cfg.WiiFit=Wiimote();		% Debug
        cfg.WiiFit.Connect();		% Debug
    catch
        errordlg('Connexion to Wii balance board has failed. Please make sure WiiLab installation script has been run and and make sure it appears in bluetooth devices!','ERREUR','modal')
        return;
    end
    
    
end