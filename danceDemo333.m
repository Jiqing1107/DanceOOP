function varargout = danceDemo333(varargin)
% DANCEDEMO333 MATLAB code for danceDemo333.fig
%      DANCEDEMO333, by itself, creates a new DANCEDEMO333 or raises the existing
%      singleton*.
%
%      H = DANCEDEMO333 returns the handle to a new DANCEDEMO333 or the handle to
%      the existing singleton*.
%
%      DANCEDEMO333('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DANCEDEMO333.M with the given input arguments.
%
%      DANCEDEMO333('Property','Value',...) creates a new DANCEDEMO333 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before danceDemo333_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to danceDemo333_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help danceDemo333

% Last Modified by GUIDE v2.5 31-Jan-2018 10:49:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @danceDemo333_OpeningFcn, ...
                   'gui_OutputFcn',  @danceDemo333_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

javaaddpath('jdbc/mysql-connector-java-5.1.25-bin.jar');

% --- Executes just before danceDemo333 is made visible.
function danceDemo333_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to danceDemo333 (see VARARGIN)

% Choose default command line output for danceDemo333
handles.output = hObject;

% define initial ui configuration
% handles.screenSize = getScreenSize();   
% handles.outputPwd = '*';
% handles.editorPanel.Visible = 'on'; % temporary
% handles.uiPanel1.Visible = 'off';  % temporary
% set(handles.playBtn, 'Enable', 'off');
% set(handles.stopBtn, 'Enable', 'off');
% set(handles.doneBtn, 'Enable', 'off');
% set(handles.selectImagesBtn, 'Enable', 'off');

% Initial variables
% handles.recommendedImg = [];
% handles.selectedImg = handles.recommendedImg;
% handles.selectedInd = zeros(1,9);
% handles.targetImg = [];
% handles.updateImg = noiseImgGeneration(handles.screenSize);
% axes(handles.iniImg);
% imshow(handles.updateImg);
% 
% handles.music = audioplayer(0, 80);
% handles.musicRawFile = [];
% handles.dancer = [];

% define some images or plots
% handles.imagesFig ={};
% handles.checkboxes = {};
% for i = 1:9
%     imgFig = strcat('handles.imgFig', num2str(i));
%     set(eval(imgFig), 'Visible', 'Off');
%     handles.imagesFig{i,1} = eval(imgFig);
%     
%     checkbox = strcat('handles.checkbox', num2str(i));
%     set(eval(checkbox), 'Visible', 'Off');
%     handles.checkboxes{i,1} = eval(checkbox);
% end


% define RSS related variables
% load('danceMAC.mat');
% load('danceMACPrim.mat');
% handles.beacon = testingMacPrim(1:4,:);
% handles.visualizationFlag = 0; % 0 means the program is off, 1 is on
% handles.currentID = '0';  % use handles.currentID for continuous processing, else just use local currentID
% handles.code = 'draft';   
% handles.accumulateData = cell(1,4);
% handles.count = 0;
% handles.runningAve = cell(1,4);
% handles.flag = 0;
% handles.sampleTrack = 5;

% Update handles structure - 
guidata(hObject, handles);

% UIWAIT makes danceDemo333 wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = danceDemo333_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loginButton.
function loginButton_Callback(hObject, eventdata, handles)
% hObject    handle to loginButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dancerID = get(handles.idInput, 'String');
password = get(handles.pwdInput, 'String');
match = checkDancer(dancerID, password);
if(match)
    handles.uipanel1.Visible = 'off';
    handles.editorPanel.Visible = 'on';
    handles.dancer = dancerID;
    set(handles.userPanel, 'Title', strcat('Dancer: ', dancerID));
    set(handles.screenResText, 'String', strcat(num2str(handles.screenSize(2)), 'x', num2str(handles.screenSize(1))));    
else
    dialogWrongPassword(dancerID)
end
guidata(hObject, handles);


% get initial image
% --- Executes on button press in noiseImgBtn.
function noiseImgBtn_Callback(hObject, eventdata, handles)
% hObject    handle to noiseImgBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noiseImgBtn
handles.updateImg = noiseImgGeneration(handles.screenSize);
axes(handles.iniImg);
imshow(handles.updateImg);
guidata(hObject, handles);



% --- Executes on button press in userDefinedImgBtn.
function userDefinedImgBtn_Callback(hObject, eventdata, handles)
% hObject    handle to userDefinedImgBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of userDefinedImgBtn
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' }, pwd,'Select Picture');
      
if(filename ~= 0)
    handles.updateImg = imresize(imread(strcat(pathname, filename)), ...
        [handles.screenSize(2), handles.screenSize(1)]);
    axes(handles.iniImg);
    imshow(handles.updateImg);
else
    set(handles.imageSelectionGroup, 'SelectedObject', handles.noiseImgBtn);
end
guidata(hObject, handles);
      


% --- Executes on button press in chooseMusicBtn.
function chooseMusicBtn_Callback(hObject, eventdata, handles)
% hObject    handle to chooseMusicBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.mp3;*.wma;','All Music Files';...
          '*.*','All Files' }, pwd,'Select Music');
currentMusic = get(handles.musicText, 'String');
    
if(filename ~= 0)
    [handles.musicRawFile Fs] = audioread(strcat(pathname, filename));
    handles.music = audioplayer(handles.musicRawFile, Fs);
    clearTheData(handles.code);
    
    set(handles.musicText, 'String', filename);
    set(handles.playBtn, 'Enable', 'on');
    set(handles.stopBtn, 'Enable', 'on');
    set(handles.doneBtn, 'Enable', 'on');
    set(handles.imgFig1, 'Visible', 'on');
    handles.recommendedImg = tabulateTheImages(handles.dancer, handles.musicRawFile, ...
        handles.imagesFig, handles.checkboxes, handles.screenSize);
else
    if(strcmp(currentMusic, 'none'))
        set(handles.musicText, 'String', 'none');
        set(handles.playBtn, 'Enable', 'off');
        set(handles.stopBtn, 'Enable', 'off');
        set(handles.doneBtn, 'Enable', 'off');
        set(handles.imgFig1, 'Visible', 'off');
    else  
        set(handles.musicText, 'String', currentMusic);
    end
end
guidata(hObject, handles);



% --- Executes on button press in playBtn.
function playBtn_Callback(hObject, eventdata, handles)
% hObject    handle to playBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
play(handles.music);

% --- Executes on button press in stopBtn.
function stopBtn_Callback(hObject, eventdata, handles)
% hObject    handle to stopBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop(handles.music);


% --- Executes on button press in doneBtn.
function doneBtn_Callback(hObject, eventdata, handles)
% hObject    handle to doneBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isplaying(handles.music))
    stop(handles.music);
end

% check if the particular table in sql is empty?
currentID = handles.currentID;
code = get(handles.codeInput,'String');
if(strcmp(code, 'Enter Dance''s Code'))
    code = 'draft';
end

if(sum(handles.selectedInd(:)==0))
   handles.selectedImg = handles.recommendedImg(1:9,:);
end
if (handles.visualizationFlag == 0)
    handles.visualizationFlag = 1;
    set(handles.doneBtn, 'String', 'Stop the interactive dance Program!');
    
        varDist = [];
        maskSize = [];
        start_interval = 5;
        
        fid = fopen('logdata/distance-300cm.csv','a') ;
        
        %handles.sampleTrack = start_interval;
%         imgIds = randperm(size(handles.selectedImg, 1));
%         current_imgIdx = 0;
        % get the music and sound effects;
        play(handles.music);
        [handles.updateImg, handles.targetImg] = startVisualization(handles.count, ...
            handles.selectedImg, handles.updateImg, handles.targetImg, varDist, maskSize);
            checkcount = []; tempID = 0;
        firstTime = true;
        while(isplaying(handles.music))
            [handles.accumulateData, handles.count, handles.currentID] = computeRSS(...
                handles.currentID, handles.code, ...
                handles.beacon, handles.accumulateData, handles.count);
             [handles.flag, handles.runningAve] = computeRunningAverage(handles.beacon, ...
                 handles.accumulateData, handles.count, handles.flag, handles.runningAve);
            [varDist, maskSize] = computeLocationChange(handles.runningAve, handles.sampleTrack, fid);
            if(size(maskSize,1)~=0)
%                fprintf('maskSize!=0\n');
%                 [handles.accumulateData, handles.count, handles.currentID] = computeRSS( ...
%                     handles.currentID, handles.code, ...
%                     handles.beacon, handles.accumulateData, handles.count);
                [handles.updateImg, handles.targetImg] = startVisualization(handles.count, ...
                        handles.selectedImg, handles.updateImg, handles.targetImg, varDist, maskSize);
                pause(0.05);

            end
    
        end
    fclose(fid);
    stop(handles.music);
    closescreen
elseif (handles.visualizationFlag == 1)
    handles.selectedInd = zeros(1,9);
    handles.visualizationFlag = 0;
    set(handles.doneBtn, 'String', 'Start Dance');
    stop(handles.music);
    closescreen();
end
guidata(hObject, handles);


% --- Executes on button press in checkBtn.
function checkBtn_Callback(hObject, eventdata, handles)
% hObject    handle to checkBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.code = get(handles.codeInput,'String');
currentID = '0';
if(strcmp(handles.code, 'Enter Dance''s Code'))
    dialogNoCodeEnter(handles.dancer);
else
    clearTheData(handles.code);
%     ind = []; 
%     k = 1;
%     while(size(unique(ind),1)~=4)
%         data = getFromSQL(currentID, handles.code); 
%         for i = 1:4
%         randInt = randi(122,[4,17]);
%         temp = unique(ind);
%         if(~ismember(i, temp))
%             set(eval(strcat('handles.',handles.beacon.h{i})), 'String', ...
%                     strcat(char(randInt(i,:)+64)));
%         end
%         end
%         pause(0.05);
%         % macFromData = unique(data(:,3))
%         if(size(data,1)>1 && sum(strcmp(data{end,3}, handles.beacon.mac))>0)
%             ind(k,1) = find(strcmp(data{end,3}, handles.beacon.mac));
%             set(eval(strcat('handles.',handles.beacon.h{ind(end,1)})), 'String', ...
%                 strcat(handles.beacon.mac{ind(end,1)},{' '}, char(hex2dec('2713'))));
%             k = k+1;
%             currentID = num2str(data{end,1}-1);
%         end
%     end
    handles.currentID = currentID;
    handles.count = 0;
    handles.runningAve = cell(1,4);
    handles.flag = 0;
    handles.accumulateData = cell(1,4);
    for i = 1:4
        handles.accumulateData{1,i} = table();
    end
    %set(handles.doneBtn, 'Enable', 'On');
end

guidata(hObject, handles);


% --- Executes on button press in selectImagesBtn.
function selectImagesBtn_Callback(hObject, eventdata, handles)
% hObject    handle to selectImagesBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedImg = handles.recommendedImg(handles.selectedInd==1);
guidata(hObject, handles); 

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedInd(1) = get(hObject,'Value'); 
if(sum(handles.selectedInd~=0))
    set(handles.selectImagesBtn, 'Enable', 'On');
else
    set(handles.selectImagesBtn, 'Enable', 'Off');
end
guidata(hObject, handles);
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedInd(2) = get(hObject,'Value');
if(sum(handles.selectedInd~=0))
    set(handles.selectImagesBtn, 'Enable', 'On');
else
    set(handles.selectImagesBtn, 'Enable', 'Off');
end
guidata(hObject, handles);
% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedInd(3) = get(hObject,'Value');
if(sum(handles.selectedInd~=0))
    set(handles.selectImagesBtn, 'Enable', 'On');
else
    set(handles.selectImagesBtn, 'Enable', 'Off');
end
guidata(hObject, handles);
% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedInd(4) = get(hObject,'Value');
if(sum(handles.selectedInd~=0))
    set(handles.selectImagesBtn, 'Enable', 'On');
else
    set(handles.selectImagesBtn, 'Enable', 'Off');
end
guidata(hObject, handles);
% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedInd(5) = get(hObject,'Value');
if(sum(handles.selectedInd~=0))
    set(handles.selectImagesBtn, 'Enable', 'On');
else
    set(handles.selectImagesBtn, 'Enable', 'Off');
end
guidata(hObject, handles);
% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedInd(6) = get(hObject,'Value');
if(sum(handles.selectedInd~=0))
    set(handles.selectImagesBtn, 'Enable', 'On');
else
    set(handles.selectImagesBtn, 'Enable', 'Off');
end
guidata(hObject, handles);
% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedInd(7) = get(hObject,'Value');
if(sum(handles.selectedInd~=0))
    set(handles.selectImagesBtn, 'Enable', 'On');
else
    set(handles.selectImagesBtn, 'Enable', 'Off');
end
guidata(hObject, handles);
% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedInd(8) = get(hObject,'Value');
if(sum(handles.selectedInd~=0))
    set(handles.selectImagesBtn, 'Enable', 'On');
else
    set(handles.selectImagesBtn, 'Enable', 'Off');
end
guidata(hObject, handles);
% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedInd(9) = get(hObject,'Value');
if(sum(handles.selectedInd~=0))
    set(handles.selectImagesBtn, 'Enable', 'On');
else
    set(handles.selectImagesBtn, 'Enable', 'Off');
end
guidata(hObject, handles);


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes during object creation, after setting all properties.
function doneBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to doneBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
