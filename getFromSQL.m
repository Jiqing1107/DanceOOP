function data = getFromSQL(currentID,code)

    sname = '143.89.45.96';
    username = 'dancerPrim';
    pwd = 'dancerPrim';
    dbname = 'dancerPrim';

    conn = database(dbname,username,pwd, 'Vendor','MySQL', 'Server',sname);
    
    if(currentID == '0')
        sql = strcat('SELECT id, beaconRSSI, beaconMac, beaconDetectedTime, reg_date FROM dancerbeacon_',code);
    else
        sql = strcat('SELECT id, beaconRSSI, beaconMac, beaconDetectedTime, reg_date FROM dancerbeacon_', code, ' where id >= ', ...
            currentID);
    end

    
    curs = exec(conn,sql);
    curs = fetch(curs);
    data = curs.Data;

    close(conn)
end