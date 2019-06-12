function varargout = Fano(varargin)
% FANO MATLAB code for Fano.fig
%      FANO, by itself, creates a new FANO or raises the existing
%      singleton*.
%
%      H = FANO returns the handle to a new FANO or the handle to
%      the existing singleton*.
%
%      FANO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FANO.M with the given input arguments.
%
%      FANO('Property','Value',...) creates a new FANO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fano_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fano_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fano

% Last Modified by GUIDE v2.5 28-May-2019 15:34:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fano_OpeningFcn, ...
                   'gui_OutputFcn',  @Fano_OutputFcn, ...
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


% --- Executes just before Fano is made visible.
function Fano_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fano (see VARARGIN)

% Choose default command line output for Fano
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fano wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fano_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = guihandles;
handles = h;
handles.Prob  = getappdata(0, 'Prob');
handles.Num  = getappdata(0, 'NumFano');
len = length(handles.Prob);

if(isnan(handles.Num))
    [~, ~, ~, handles.process] = FanoEncode(handles.Prob);
    handles.Show = handles.process(1 : len, :);
    set(handles.Process,'data',handles.Show( : , 1));
    handles.Num = 2;
    setappdata(0, 'NumFano', handles.Num);
    setappdata(0, 'ProcessFano', handles.Show);
else
    handles.Show = getappdata(0, 'ProcessFano');
    if( (size(handles.Show, 2) ~= 1) && (handles.Num < size(handles.Show, 2)))
        tempCol = handles.Show( : , handles.Num);     % 特殊显示的某列（原始）
        for i = 1 : len
            if(length(tempCol{i, 1}) < handles.Num)
                tempshow{i, 1} = [];
            else
                tempshow{i, 1} = tempCol{i, 1}(handles.Num);
            end
        end
        handles.Show( : , handles.Num) = tempshow;
        set(handles.Process,'data',handles.Show( : , 1 : handles.Num));
        setappdata(0, 'ProcessFano', handles.Show);
    elseif(handles.Num == size(handles.Show, 2))
        tempCol = handles.Show( : , handles.Num);     % 特殊显示的某列（原始）
        for i = 1 : len
            if(length(tempCol{i, 1}) < handles.Num)
                tempshow{i, 1} = [];
            else
                tempshow{i, 1} = tempCol{i, 1}(handles.Num);
            end
        end
        handles.Show( : , handles.Num) = tempshow;
        handles.Show( : , handles.Num + 1) = tempCol;
        set(handles.Process,'data',handles.Show);
    end
    
    if(handles.Num <= size(handles.Show, 2))
        handles.Num = handles.Num + 1;
        setappdata(0, 'NumFano', handles.Num);
    else
        warndig = warndlg('已到达最后一步', '提示');
        strdig = findobj(warndig, 'tag', 'MessageBox');
        set(strdig,'FontSize',12, 'FontName','微软雅黑');
    end
end
