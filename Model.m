% Model class
classdef Model < handle
    properties
        code
        timerObj
        runningAverager
        reader
        running = false
        algorithm
    end
    events
        sensorUpdated
    end
    methods
        function obj = Model()
            obj.code = 'draft';
            obj.timerObj = timer('StartDelay', 1, 'Period', 0.1, ...
                'ExecutionMode', 'fixedRate');
            obj.timerObj.TimerFcn = @obj.callback_timer;
            obj.runningAverager = RunningAverager(500);
            obj.algorithm = Algorithm();
        end
        function reset(obj)
            clearTheData(obj.code);
            obj.reader = SensorReader(obj.code);
        end
        function startEngine(obj)
            obj.running = true;
            start(obj.timerObj);
            obj.reader.start();
        end
        function stopEngine(obj)
            stop(obj.timerObj);
            obj.running = false;
        end
        function callback_timer(obj, src, event)
            % read data from sql
            record = obj.reader.read();
            if size(record)~=0
                % feed into runningAverager
                obj.runningAverager.accept(record)
                if obj.runningAverager.isupdated
                    obj.notify('sensorUpdated');
                end
            end
        end
        function delete(obj)
            delete(obj.timerObj)
        end
    end
end