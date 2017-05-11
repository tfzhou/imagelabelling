function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 12-May-2017 00:21:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenImages_Callback(hObject, eventdata, handles)
% hObject    handle to OpenImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

folderName = uigetdir;
fullPath = strcat(folderName, '/');
files = [dir(fullfile(fullPath,'*jpg')); dir(fullfile(fullPath,'*.jpeg')); dir(fullfile(fullPath,'*.png'))];
handles.files = files;

set(handles.imagelistbox,'String', {files.name});

% Show the first image
axes(handles.axesImage);
im = imread([fullPath files(1).name]);
himage = imshow(im);


handles.f = 1;
handles.fullPath = fullPath;

handles.outer = zeros(4,2);
handles.inner = zeros(4,2);
handles.Line  = zeros(4,2);
guidata(hObject, handles);

% --------------------------------------------------------------------
function OpenAVI_Callback(hObject, eventdata, handles)
% hObject    handle to OpenAVI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonLabel.
function buttonLabel_Callback(hObject, eventdata, handles)
% hObject    handle to buttonLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axesImage);

pts = zeros(4,2);

for i = 1 : 4
    hold on
    [x,y,button] = ginput(1);
    
    pts(i,:) = [x,y];
    
    str = ['(',num2str(x,'%0.3g'),', ',num2str(y,'%0.3g'),')'];  
    text(x,y,str,'VerticalAlignment','bottom');
    plot(x,y, 'r.', 'linewidth', 2)
    drawnow 
    
    if i >= 2
        line([pts(i-1,1), pts(i,1)], [pts(i-1,2), pts(i,2)]);
    end
    
    if i == 4
        line([pts(i,1) pts(1,1)], [pts(i,2) pts(1,2)]);
    end
end

handles.outer = pts;
guidata(hObject, handles);


% --- Executes on button press in buttonReset.
function buttonReset_Callback(hObject, eventdata, handles)
% hObject    handle to buttonReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.outer = [];
handles.inner = [];
handles.line = [];

axes(handles.axesImage);
im = imread([handles.fullPath handles.files(handles.f).name]);
imshow(im);


% --- Executes on button press in buttonPrev.
function buttonPrev_Callback(hObject, eventdata, handles)
% hObject    handle to buttonPrev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.f > 0
  
  handles.f = handles.f - 1;
  guidata(hObject, handles);
  
  axes(handles.axesImage);
  im = imread([handles.fullPath handles.files(handles.f).name]);
  imshow(im);

end


% --- Executes on button press in buttonNext.
function buttonNext_Callback(hObject, eventdata, handles)
% hObject    handle to buttonNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.f < length(handles.files)
  
  handles.f = handles.f + 1;
  guidata(hObject, handles);
  
  axes(handles.axesImage);
  im = imread([handles.fullPath handles.files(handles.f).name]);
  imshow(im);
  
end


% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.textX)
%   handles.gt(handles.f,:) = [handles.textX, handles.textY, handles.textW, handles.textH];
  handles.gt(handles.f,:) = handles.r(:)';
  guidata(hObject, handles);
end






% --- Executes on button press in buttonDone.
function buttonDone_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% temp = handles.gt;
% save label_gt temp


% --- Executes on button press in LInner.
function LInner_Callback(hObject, eventdata, handles)
% hObject    handle to LInner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axesImage);

pts = zeros(4,2);

for i = 1 : 4
    hold on
    [x,y,button] = ginput(1);
    
    pts(i,:) = [x,y];
    
    str = ['(',num2str(x,'%0.3g'),', ',num2str(y,'%0.3g'),')'];  
    text(x,y,str,'VerticalAlignment','bottom');
    plot(x,y, 'r.', 'linewidth', 2)
    drawnow 
    
    if i >= 2
        line([pts(i-1,1), pts(i,1)], [pts(i-1,2), pts(i,2)]);
    end
    
    if i == 4
        line([pts(i,1) pts(1,1)], [pts(i,2) pts(1,2)]);
    end
end

handles.inner = pts;
guidata(hObject, handles);


% --- Executes on button press in LLine.
function LLine_Callback(hObject, eventdata, handles)
% hObject    handle to LLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axesImage);

pts1 = zeros(2,2);

for i = 1 : 2
    hold on
    [x,y,button] = ginput(1);
    
    pts1(i,:) = [x,y];
    
    str = ['(',num2str(x,'%0.3g'),', ',num2str(y,'%0.3g'),')'];  
    text(x,y,str,'VerticalAlignment','bottom');
    plot(x,y, 'r.', 'linewidth', 2)
    drawnow 
    
    if i == 2
        line([pts1(i-1,1), pts1(i,1)], [pts1(i-1,2), pts1(i,2)]);
    end
end

pts2 = zeros(2,2);
for i = 1 : 2
    hold on
    [x,y,button] = ginput(1);
    
    pts2(i,:) = [x,y];
    
    str = ['(',num2str(x,'%0.3g'),', ',num2str(y,'%0.3g'),')'];  
    text(x,y,str,'VerticalAlignment','bottom');
    plot(x,y, 'r.', 'linewidth', 2)
    drawnow 
    
    if i == 2
        line([pts2(i-1,1), pts2(i,1)], [pts2(i-1,2), pts2(i,2)]);
    end
end


handles.line = [pts1; pts2];
guidata(hObject, handles);


% --- Executes on selection change in imagelistbox.
function imagelistbox_Callback(hObject, eventdata, handles)
% hObject    handle to imagelistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns imagelistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from imagelistbox

if strcmp(get(hObject,'SelectionType'), 'Open')
    'I do what I want! But only when clicked twice!'
end

% axes(handles.axesImage);
% num=get(hObject,'value');
% switch num
%     case 1
%         contents = cellstr(get(hObject,'String'));
%         im = imread([handles.fullPath contents]);
%         imshow(im);
% end



% --- Executes during object creation, after setting all properties.
function imagelistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagelistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

