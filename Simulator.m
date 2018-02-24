classdef Simulator < handle
    properties
        cursor = 1
        dd
    end
    methods
        function obj = Simulator()
            obj.dd = readtable('../Proximity5_hand.csv');
            disp('table readed.')
        end
        function start(obj)
            disp('start simulation...');
            tic
        end
        function data = getFromSQL(obj, cursor, code)
            currentTime = toc*1000;
            % get the records till currentTime
            data = {};
            currentData = obj.next(currentTime);
            while ~obj.isdone() && size(currentData,1)~=0;
                if size(data,1)==0
                    data = currentData;
                else
                    data = [data;currentData];
                end
                currentData = obj.next(currentTime);
            end
        end
        function data = next(obj, currentTime)
            data = {};
            if obj.isdone()
                return;
            end
            while isnan(obj.dd(obj.cursor,:).beaconDetectedTime)
                obj.cursor = obj.cursor + 1;
            end
            if obj.dd(obj.cursor,:).beaconDetectedTime<currentTime
                data = {obj.dd(obj.cursor,:).id, obj.dd(obj.cursor,:).beaconRSSI, ...
                        obj.dd(obj.cursor,:).beaconMac{1,1}, obj.dd(obj.cursor,:).beaconDetectedTime,...
                        obj.dd(obj.cursor,:).reg_date{1,1}};
                obj.cursor = obj.cursor + 1;
            end
        end
        function done = isdone(obj)
            done = obj.cursor>height(obj.dd);
            if done
                disp('data completed.');
            end
        end
    end
end