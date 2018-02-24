simulator = Simulator();
simulator.start();
cursor = '0';
while ~simulator.isdone()
    data = simulator.getFromSQL(cursor, 0);
    if size(data,1)>0
        cursor = num2str(data{end,1}-1);
        record = cell2table(data, 'VariableNames',{'id' 'rss' 'mac' 'time' 'date'});
        fprintf('currentID=%d, rss=%d, mac=%s, time=%d, date=%s\n', data{end,1}, data{end,2}, data{end,3}, data{end,4}, data{end,5});
    end
    pause(0.05);
end