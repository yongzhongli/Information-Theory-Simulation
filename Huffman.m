function varargout = Huffman(varargin)
% HUFFMAN MATLAB code for Huffman.fig
%      HUFFMAN, by itself, creates a new HUFFMAN or raises the existing
%      singleton*.
%
%      H = HUFFMAN returns the handle to a new HUFFMAN or the handle to
%      the existing singleton*.
%
%      HUFFMAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HUFFMAN.M with the given input arguments.
%
%      HUFFMAN('Property','Value',...) creates a new HUFFMAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Huffman_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Huffman_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Huffman

% Last Modified by GUIDE v2.5 28-May-2019 15:11:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Huffman_OpeningFcn, ...
                   'gui_OutputFcn',  @Huffman_OutputFcn, ...
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


% --- Executes just before Huffman is made visible.
function Huffman_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Huffman (see VARARGIN)

% Choose default command line output for Huffman
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Huffman wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Huffman_OutputFcn(hObject, eventdata, handles) 
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
handles.R  = getappdata(0, 'RHuffman');
len = length(handles.Prob);
handles.Num  = getappdata(0, 'NumHuffman');
handles.Temp = getappdata(0, 'Temp');           % 用于分部分展示

if(isnan(handles.Num))
    [~, ~, ~, handles.process] = HuffmanEncode(handles.Prob, handles.R);
    handles.process = handles.process(1 : len, :);
    set(handles.Process,'data',handles.process( : , end));
    handles.Num = 1;
    setappdata(0, 'NumHuffman', handles.Num);
    setappdata(0, 'ProcessHuffman', handles.process);
else
    handles.process = getappdata(0, 'ProcessHuffman');
    if( size(handles.process, 2) ~= 1)
        if(~handles.Temp)
            tempCol = handles.process( : , end - handles.Num);     % 特殊显示的某列（原始）
            row = size(tempCol, 1);
            tempshow = cell(row ,1);                            % 特殊显示的某列（特殊修改后）
            while(true)
                if(isempty(tempCol{row}))
                    row = row - 1;
                else
                    for i = 0 : (handles.R - 1)
                        tempshow{row - i, 1} = tempCol{row - i, 1}(1 : end - 1);
                    end
                    break
                end
            end
            setappdata(0, 'Temp', true);
            handles.Temp = true;
            tempShow = handles.process( : , end : -1 : end - handles.Num);
            tempShow( : ,end) = tempshow;
            set(handles.Process,'data',tempShow);
        else
            setappdata(0, 'Temp', false);            
            handles.Temp = false;
            set(handles.Process,'data',handles.process( : , end : -1 : end - handles.Num));
        end
    end
    
    if(~handles.Temp)
        if(handles.Num < (size(handles.process, 2) - 1))
            handles.Num = handles.Num + 1;
            setappdata(0, 'NumHuffman', handles.Num);
        else
            setappdata(0, 'Temp', true);            
            handles.Temp = true;
            warndig = warndlg('已到达最后一步', '提示');
            strdig = findobj(warndig, 'tag', 'MessageBox');
            set(strdig,'FontSize',12, 'FontName','微软雅黑');
        end
    end
end
