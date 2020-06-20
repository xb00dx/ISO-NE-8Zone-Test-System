function varargout = testbedInitializeGUI(varargin)
% TESTBEDINITIALIZEGUI MATLAB code for testbedInitializeGUI.fig
%      TESTBEDINITIALIZEGUI, by itself, creates a new TESTBEDINITIALIZEGUI or raises the existing
%      singleton*.
%
%      H = TESTBEDINITIALIZEGUI returns the handle to a new TESTBEDINITIALIZEGUI or the handle to
%      the existing singleton*.
%
%      TESTBEDINITIALIZEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTBEDINITIALIZEGUI.M with the given input arguments.
%
%      TESTBEDINITIALIZEGUI('Property','Value',...) creates a new TESTBEDINITIALIZEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testbedInitializeGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testbedInitializeGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testbedInitializeGUI

% Last Modified by GUIDE v2.5 26-Oct-2014 22:01:49

% Begin initialization code - DO NOT EDIT
clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testbedInitializeGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @testbedInitializeGUI_OutputFcn, ...
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


% --- Executes just before testbedInitializeGUI is made visible.
function testbedInitializeGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testbedInitializeGUI (see VARARGIN)

% Choose default command line output for testbedInitializeGUI
handles.output = hObject;

set(handles.noPenCB,'Value',1);
set(handles.detSCUCCB,'Value',1);
set(handles.stoSCUCCB,'Value',1);
set(handles.numGenEdit,'string','genData_GUI.mat');
set(handles.capMarEdit,'string','125');
set(handles.sRREdit,'string','10');
set(handles.RREdit,'string','1000');
set(handles.sSSCostEdit,'string','1');
set(handles.sNLCostEdit,'string','1');
set(handles.windVolEdit,'string','1');
set(handles.maxDayEdit,'string','2');
set(handles.numSCNEdit,'string','5');
set(handles.scalingFactorLoadEdit,'string','1');
set(handles.monthLB,'Value',1);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testbedInitializeGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testbedInitializeGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in initializePB.
function initializePB_Callback(hObject, eventdata, handles)
% hObject    handle to initializePB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numGenGUI = get(handles.numGenEdit,'string');
capMarGUI = str2num(get(handles.capMarEdit,'string'));
SRRGUI = str2num(get(handles.sRREdit,'string'));
RRGUI = str2num(get(handles.RREdit,'string'));
SSSCostGUI = str2num(get(handles.sSSCostEdit,'string'));
SNLCostGUI = str2num(get(handles.sNLCostEdit,'string'));
windPenGUI = [];
if(get(handles.lowPenCB,'Value'))
    windPenGUI = [windPenGUI 0.1];
end
if(get(handles.medPenCB,'Value'))
    windPenGUI = [windPenGUI 0.2];
end
if(get(handles.highPenCB,'Value'))
    windPenGUI = [windPenGUI 0.3];
end
if(get(handles.noPenCB,'Value'))
    windPenGUI = [windPenGUI 0];
end
typeOfSCUCGUI=[];
if(get(handles.detSCUCCB,'Value'))
    typeOfSCUCGUI = [typeOfSCUCGUI 0];
end
if(get(handles.stoSCUCCB,'Value'))
    typeOfSCUCGUI = [typeOfSCUCGUI 1];
end
if(isempty(typeOfSCUCGUI))
    display('Error : Initialization Failed');
end
windVolGUI = str2num(get(handles.windVolEdit,'string'));
maxDayGUI = str2num(get(handles.maxDayEdit,'string'));
numSCNGUI = str2num(get(handles.numSCNEdit,'string'));
scalingFactorLoadGUI = str2num(get(handles.scalingFactorLoadEdit,'string'));
setOfMonthsGUI = get(handles.monthLB,'Value');
numRealizedSCNGUI = 10;
disp('Initializing ... ')
disp(' ')
disp(['Number of Scenarios : ' num2str(numSCNGUI)])
disp(['Max Day of Simulation : ' num2str(maxDayGUI)])
disp(['Generator : ' numGenGUI])
disp(' ')
disp(['Number of months treatments: ' num2str(length(setOfMonthsGUI))])
disp(['Number of wind penetration treatments : ' num2str(length(windPenGUI))])
disp(['Number of reserve treatments : ' num2str(length(SRRGUI))])
disp(' ')
disp('Completed Initialization. Run main.m to generate testcases.')
save('../data/initializeData/gui.mat')


% --- Executes on button press in createTestCasesPB.
function createTestCasesPB_Callback(hObject, eventdata, handles)
% hObject    handle to createTestCasesPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
initialize


function numGenEdit_Callback(hObject, eventdata, handles)
% hObject    handle to numGenEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numGenEdit as text
%        str2double(get(hObject,'String')) returns contents of numGenEdit as a double


% --- Executes during object creation, after setting all properties.
function numGenEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numGenEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in detSCUCCB.
function detSCUCCB_Callback(hObject, eventdata, handles)
% hObject    handle to detSCUCCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of detSCUCCB


% --- Executes on button press in stoSCUCCB.
function stoSCUCCB_Callback(hObject, eventdata, handles)
% hObject    handle to stoSCUCCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stoSCUCCB



function capMarEdit_Callback(hObject, eventdata, handles)
% hObject    handle to capMarEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of capMarEdit as text
%        str2double(get(hObject,'String')) returns contents of capMarEdit as a double


% --- Executes during object creation, after setting all properties.
function capMarEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to capMarEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sSSCostEdit_Callback(hObject, eventdata, handles)
% hObject    handle to sSSCostEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sSSCostEdit as text
%        str2double(get(hObject,'String')) returns contents of sSSCostEdit as a double


% --- Executes during object creation, after setting all properties.
function sSSCostEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sSSCostEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sNLCostEdit_Callback(hObject, eventdata, handles)
% hObject    handle to sNLCostEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sNLCostEdit as text
%        str2double(get(hObject,'String')) returns contents of sNLCostEdit as a double


% --- Executes during object creation, after setting all properties.
function sNLCostEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sNLCostEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sRREdit_Callback(hObject, eventdata, handles)
% hObject    handle to sRREdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sRREdit as text
%        str2double(get(hObject,'String')) returns contents of sRREdit as a double


% --- Executes during object creation, after setting all properties.
function sRREdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sRREdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function windVolEdit_Callback(hObject, eventdata, handles)
% hObject    handle to windVolEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windVolEdit as text
%        str2double(get(hObject,'String')) returns contents of windVolEdit as a double


% --- Executes during object creation, after setting all properties.
function windVolEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windVolEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxDayEdit_Callback(hObject, eventdata, handles)
% hObject    handle to maxDayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxDayEdit as text
%        str2double(get(hObject,'String')) returns contents of maxDayEdit as a double


% --- Executes during object creation, after setting all properties.
function maxDayEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxDayEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numSCNEdit_Callback(hObject, eventdata, handles)
% hObject    handle to numSCNEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numSCNEdit as text
%        str2double(get(hObject,'String')) returns contents of numSCNEdit as a double


% --- Executes during object creation, after setting all properties.
function numSCNEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numSCNEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in monthLB.
function monthLB_Callback(hObject, eventdata, handles)
% hObject    handle to monthLB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns monthLB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from monthLB


% --- Executes during object creation, after setting all properties.
function monthLB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to monthLB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RREdit_Callback(hObject, eventdata, handles)
% hObject    handle to RREdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RREdit as text
%        str2double(get(hObject,'String')) returns contents of RREdit as a double


% --- Executes during object creation, after setting all properties.
function RREdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RREdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in lowPenCB.
function lowPenCB_Callback(hObject, eventdata, handles)
% hObject    handle to lowPenCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (get(hObject,'Value') == get(hObject,'Max'))
	display('Selected');
else
	display('Not selected');
end
% Hint: get(hObject,'Value') returns toggle state of lowPenCB


% --- Executes on button press in medPenCB.
function medPenCB_Callback(hObject, eventdata, handles)
% hObject    handle to medPenCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (get(hObject,'Value') == get(hObject,'Max'))
	display('Selected');
else
	display('Not selected');
end
% Hint: get(hObject,'Value') returns toggle state of medPenCB


% --- Executes on button press in highPenCB.
function highPenCB_Callback(hObject, eventdata, handles)
% hObject    handle to highPenCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (get(hObject,'Value') == get(hObject,'Max'))
	display('Selected');
else
	display('Not selected');
end
% Hint: get(hObject,'Value') returns toggle state of highPenCB


% --- Executes on button press in noPenCB.
function noPenCB_Callback(hObject, eventdata, handles)
% hObject    handle to noPenCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noPenCB



function scalingFactorLoadEdit_Callback(hObject, eventdata, handles)
% hObject    handle to scalingFactorLoadEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scalingFactorLoadEdit as text
%        str2double(get(hObject,'String')) returns contents of scalingFactorLoadEdit as a double


% --- Executes during object creation, after setting all properties.
function scalingFactorLoadEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scalingFactorLoadEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
