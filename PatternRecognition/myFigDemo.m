function varargout = myFigDemo(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myFigDemo_OpeningFcn, ...
                   'gui_OutputFcn',  @myFigDemo_OutputFcn, ...
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
% --- Executes just before myFigDemo is made visible.
function myFigDemo_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
clc;
set(handles.txtStatue,'String','ŷʽ���뷨');
handles.menuType='11';
guidata(hObject, handles);
% --- Outputs from this function are returned to the command line.
function varargout = myFigDemo_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
h=handles.activex5;
data=invoke(h,'GetFeature');
menuType = handles.menuType;
r = 0;
switch menuType
    case '11'
        r = neartempleta(data);
        msgbox(num2str(r),'ʶ����');
    case '21'
        r = bpnet(data);
        msgbox(num2str(r),'ʶ����');
    case '31'
        r = bayeser(data);
        msgbox(num2str(r),'ʶ����');
end
guidata(hObject,handles);
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
h=handles.activex5;
h.invoke('Clear');
% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function EuclideanDistance_Callback(hObject, eventdata, handles)
set(handles.txtStatue,'String','ŷʽ���뷨');
h=handles.activex5;
h.invoke('Clear');
set(handles.pushbutton1,'String','ʶ��');
handles.menuType='11';
guidata(hObject,handles);
% --------------------------------------------------------------------
function BPMenu_Callback(hObject, eventdata, handles)
set(handles.txtStatue,'String','BP�����編');
h=handles.activex5;
h.invoke('Clear');
%set(handles.pushbutton1,'String','ѵ��');
handles.menuType='21';
%bpgdtrain();  %��Ҫ�۲�ѵ��������ȥ��ע��
guidata(hObject,handles);
% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function ByeseClassfiy_Callback(hObject, eventdata, handles)
set(handles.txtStatue,'String','��Ҷ˹���෨');
h=handles.activex5;
h.invoke('Clear');
handles.menuType='31';
guidata(hObject,handles);