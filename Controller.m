% Controller class
classdef Controller < handle
    properties
        viewObj
        modelObj
    end
    methods
        function obj = Controller(viewObj, modelObj)
            obj.viewObj = viewObj;
            obj.modelObj = modelObj;
        end
        function callback_checkBtn(obj, src, event)
            obj.modelObj.code = get(obj.viewObj.gui_h.codeInput, 'String');
            if(strcmp(obj.modelObj.code, 'Enter Dance''s Code'))
                dialogNoCodeEnter(obj.viewObj.dancer);
            else
                obj.modelObj.reset();
            end
        end
        function callback_noiseImgBtn(obj, src, event)
            obj.viewObj.updateImg = noiseImgGeneration(obj.viewObj.screenSize);
            % axes(obj.viewObj.iniImg);
            imshow(obj.viewObj.updateImg, 'Parent', obj.viewObj.gui_h.iniImg);
        end
        function callback_userDefinedImgBtn(obj, src, event)
            [filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
                '*.*','All Files' }, pwd,'Select Picture');

            if(filename ~= 0)
                obj.viewObj.updateImg = imresize(imread(strcat(pathname, filename)), ...
                    [obj.viewObj.screenSize(2), obj.viewObj.screenSize(1)]);
                axes(obj.viewObj.iniImg);
                imshow(obj.viewObj.updateImg);
            else
                % set(handles.imageSelectionGroup, 'SelectedObject', handles.noiseImgBtn);
            end
        end
        function callback_chooseMusicBtn(obj, src, event)
            [filename, pathname] = uigetfile({'*.mp3;*.wma;','All Music Files';...
                      '*.*','All Files' }, pwd,'Select Music');
            currentMusic = get(obj.viewObj.gui_h.musicText, 'String');

            if(filename ~= 0)
                [obj.viewObj.musicRawFile, Fs] = audioread(strcat(pathname, filename));
                obj.viewObj.music = audioplayer(obj.viewObj.musicRawFile, Fs);
                clearTheData(obj.modelObj.code);

                set(obj.viewObj.gui_h.musicText, 'String', filename);
                set(obj.viewObj.gui_h.playBtn, 'Enable', 'on');
                set(obj.viewObj.gui_h.stopBtn, 'Enable', 'on');
                set(obj.viewObj.gui_h.doneBtn, 'Enable', 'on');
                set(obj.viewObj.gui_h.imgFig1, 'Visible', 'on');
                obj.viewObj.recommendedImg = tabulateTheImages(obj.viewObj.dancer, obj.viewObj.musicRawFile, ...
                    obj.viewObj.imagesFig, obj.viewObj.checkboxes, obj.viewObj.screenSize);
            else
                if(strcmp(currentMusic, 'none'))
                    set(obj.viewObj.gui_h.musicText, 'String', 'none');
                    set(obj.viewObj.gui_h.playBtn, 'Enable', 'off');
                    set(obj.viewObj.gui_h.stopBtn, 'Enable', 'off');
                    set(obj.viewObj.gui_h.doneBtn, 'Enable', 'off');
                    set(obj.viewObj.gui_h.imgFig1, 'Visible', 'off');
                else  
                    set(obj.viewObj.gui_h.musicText, 'String', currentMusic);
                end
            end
        end
        function callback_playBtn(obj, src, event)
            play(obj.viewObj.music);
        end
        function callback_stopBtn(obj, src, event)
            stop(obj.viewObj.music);
        end
        function callback_doneBtn(obj, src, event)
            if ~obj.modelObj.running
                set(obj.viewObj.gui_h.doneBtn, 'String', 'Stop the interactive dance Program!');
                obj.modelObj.startEngine();
                obj.viewObj.startVisualize();
            else
                obj.viewObj.stopVisualize();
                obj.modelObj.stopEngine();
                set(obj.viewObj.gui_h.doneBtn,'String', 'Start Dance');
            end
        end
        function callback_keypress(obj, src, event)
%             if strcmp(event.Key, 'escape')
                disp('escape pressed.');
                obj.viewObj.stopVisualize();
                obj.modelObj.stopEngine();
                set(obj.viewObj.gui_h.doneBtn,'String', 'Start Dance');
%             end
        end
    end
    
end