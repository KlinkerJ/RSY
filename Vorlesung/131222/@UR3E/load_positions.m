function positions = load_positions(obj)

    pih= pi/2;
    piv = pi/4;
    pia = pi/8;
    
    KERZE = [0; -pih; 0; 0; pih; pih];
    HOME_UNTEN = [-piv, -pih, -pih, -pih, pih, 0];

    positions = [KERZE]; % andere pos hinzufügen!

end