classdef Algorithm < handle
    properties
    
    end
    methods
        function [HorF, sizing] = predict(obj, data)
            hand = abs(data(1,1) - data(1,3));
            foot = abs(data(1,2) - data(1,4));
            if (hand < foot)
                HorF = 1;
            else
                HorF = 2;
            end
            signal_strength = mean(data(data~=0));
            sizing = (signal_strength+80)/10;
            fprintf('signal=%d, maskSize=%f\n', signal_strength, sizing);
        end
    end
end