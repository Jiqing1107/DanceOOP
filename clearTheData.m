function clearTheData(code)

    sname = '143.89.45.96';
    username = 'dancerPrim';
    pwd = 'dancerPrim';
    dbname = 'dancerPrim';

    conn = database(dbname,username,pwd, 'Vendor','MySQL', 'Server',sname);
    
    sql = strcat('TRUNCATE TABLE dancerbeacon_',code);

    curs = exec(conn,sql);
    curs = fetch(curs);

    close(conn)
end