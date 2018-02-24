classdef RunningAverager < handle
   properties(Constant)
      mac = {'98:7B:F3:2E:0A:9E', '68:9E:19:0F:3D:49', '98:7B:F3:2D:FF:60',...
          '68:9E:19:10:C7:A1'};
   end
   properties
      rss
      mapObj
      status
      aveInterval = 500
   end
   methods
       function obj = RunningAverager(intervalTime)
           disp('RunningAverager started.');
           obj.rss = cell(1,4);
           valueSet = {1,2,3,4};
           obj.mapObj = containers.Map(obj.mac,valueSet);
           obj.status = false(1,4);
           if nargin==1
               % specified the averaging time window size
               obj.aveInterval = intervalTime;
           end
       end
       
       function accept(obj, record)
           for i=1:height(record)
               if isKey(obj.mapObj, record.mac{i,1})
                   index = obj.mapObj(record.mac{i,1});
                   rsst = obj.rss{index};
                   rsst(end+1,:) = [record.time(i,1), record.rss(i,1)];
                   % may need to sort the incoming record
                   obj.rss{index} = rsst;
                   obj.status(index) = true;
               end
           end
       end
       
       function ready = isupdated(obj)
           ready = all(obj.status);
       end
       
       function [data, endTime] = getData(obj)
           % return the current running average for all 4 beacons if
           % beacons are ready
           data = [];
           endTime = 0;
           if obj.isupdated
               % data update trigger when all 4 beacons have been updated
               % get the latest time stamp
               times = zeros(1,4);
               for i=1:length(obj.rss)
                   rsst = obj.rss{i};
                   times(i) = rsst(end, 1);
               end
               endTime = max(times);
               startTime = max(0,endTime - obj.aveInterval);
               % running average within aveInterval
               for i=1:length(obj.rss)
                   rsst = obj.rss{i};
                   rsst = rsst(max(1,end-100):end, :);
                   data(1, i) = mean(rsst(rsst(:,1)>startTime,2));
               end
               obj.status(:) = false;
           end
       end
   end
end