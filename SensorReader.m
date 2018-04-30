classdef SensorReader < handle
    properties
        cursor = '0'
        code
        simulator
    end
    methods
        function obj = SensorReader(code)
            obj.code = code;
            % obj.simulator = Simulator();
        end
        function start(obj)
            % obj.simulator.start();
        end
        function record = read(obj)
            record = [];
            data = getFromSQL(obj.cursor,obj.code);
            % for simulation
            % data = obj.simulator.getFromSQL(obj.cursor, obj.code);
            if size(data,2)==5
                obj.cursor = num2str(data{end,1});
                disp(data);
                record = cell2table(data, 'VariableNames',{'id' 'rss' 'mac' 'time' 'date'});
            end
        end
    end
end